##|
##|  Popup window widget
##|
##|  This class creates a popup window That has a title and is dragable.
##|
##|  @example
##|      popup = new PoupWindow(title, x, y)
##|

globalOpenWindowList = []



## -------------------------------------------------------------------------------------------------------------
## Popup window widget
## this class creates a popup window that has a title and its dragable.
##
## @example popup = new PopupWindow(title, x, y)
##
class PopupWindow

	# @property [Integer] popupWidth the width of the popup default 600
	popupWidth:  600

	# @property [Integer] popupHeight the height of the popup default 400
	popupHeight: 400

	# @property [Boolean] isVisible if popup is visible on current screen default false
	isVisible:   false

	# @property [Boolean] allowHorizontalScroll if horizontal scrollable default false
	allowHorizontalScroll: false

	# @property [Object] configurations the configurations about table and savable popup
	configurations:
		tableName  : null
		keyValue   : null
		windowName : null
		resizable  : true
		scrollable : true

	## -------------------------------------------------------------------------------------------------------------
	## returns the available height for the body element
	##
	## @return [Integer] h the available height
	##
	getBodyHeight: () =>
		h = @popupHeight
		h -= 1 ## top padding
		h -= 1 ## bottom padding
		h -= @windowTitle.height()
		return h

	## -------------------------------------------------------------------------------------------------------------
	## update the display, must be called if the height of the body content changes
	##
	update: () =>
		if @configurations.scrollable
			@myScroll.refresh();

	## -------------------------------------------------------------------------------------------------------------
	## makes popup visible and render on the current screen
	##
	## @return [Boolean]
	##
	open: () =>

		if @configurations.scrollable
			setTimeout () =>
				@update()
			, 20

		@popupWindowHolder.show()
		@isVisible = true
		true

	## -------------------------------------------------------------------------------------------------------------
	## closes the popup and make it invisible in the current screen
	##
	## @param [Event] jquery event object
	## @event close
	## @return [Boolean]
	##
	close: (e) =>
		if typeof e != "undefined" and e != null
			e.preventDefault()
			e.stopPropagation()

		@
		@popupWindowHolder.hide()
		@isVisible = false
		false

	## -------------------------------------------------------------------------------------------------------------
	## destroy the popup menu which will remove the associated html also
	##
	## @return [Boolean]
	##
	destroy: () =>

		##|
		##| Remove this from the global open window list
		list = globalOpenWindowList
		globalOpenWindowList = []
		for l in list
			if l != this then globalOpenWindowList.push l

		@close()
		@popupWindowHolder.remove()
		true

	##|
	##|  Do our best to center the window on a given point, however, don't go offscreen
	centerToPoint: (x, y)=>

		width  = $(window).width()
		height = $(window).height()

		if @popupWidth > width
			@popupWidth = width

		if @popupHeight > height
			@popupHeight = height

		px = x - (@popupWidth / 2)
		py = y - (@popupHeight / 2)

		if px < 0 then px = 0
		if py < 0 then py = 0
		if px + @popupWidth > width then px = width - @popupWidth
		if py + @popupHeight > height then py = height - @popupHeight

		@popupWindowHolder.css
			left:   @x
			top:    @y

	## -------------------------------------------------------------------------------------------------------------
	## aligns the popup in the center of the screen it calculates current screen height and width
	##
	center: () =>
		width  = $(window).width()
		height = $(window).height()
		@x = (width - @popupWidth) / 2
		@y = (height - @popupHeight) / 2
		@y += $(window).scrollTop()

		while @x < 0
			@x++
			@popupWidth--

		while @y < 0
			@y++
			@popupHeight--

		console.log "Center: #{@x}, #{@y} (#{@popupWidth}, #{@popupHeight})"

		@popupWindowHolder.css
			left:   @x
			top:    @y

	## -------------------------------------------------------------------------------------------------------------
	## Makes this popup window modal
	##
	modal: (@popupWidth, @popupHeight) =>

		@shield = $ "<div />"
		@shield.css
			zIndex          : parseInt(@popupWindowHolder.css "zIndex") - 10
			position        : "absolute"
			left            : 0
			top             : 0
			right           : 0
			bottom          : 0
			backgroundColor : "rgba(0,0,0,0.6)"

		$(document).on "keypress", (e)=>
			console.log "KEY=", e
			false

		@center()
		$("body").append @shield

	## -------------------------------------------------------------------------------------------------------------
	## resize the window to a new size
	##
	## @param [Integer] popupWidth the new width
	## @param [Integer] popupHeight the new height
	## @return [Boolean]
	##
	resize: (@popupWidth, @popupHeight) =>

		width  = $(window).width()
		height = $(window).height()

		console.log "popupWindow #{@title}, width=#{width} height=#{height} : #{@popupWidth} x #{@popupHeight} (x=#{@x}, y=#{@y})"
		if @x == 0 and @y == 0
			@center()

		if @x < 0
			@x = 0

		if @y < 0
			@y = 0

		if @x + @popupWidth + 10> width
			console.log "popupWindow #{@title}, moving because #{@x} + #{@popupWidth} + 10 > #{width}"
			@x = width - @popupWidth - 10

		## adjustment of 24px for the resize handle so resize handle doesn't overlap
		@popupHeight += 24

		if @y + @popupHeight + 10 > height
			@y = height - @popupHeight - 10

		while @x < 10
			@x++
			@popupWidth--

		while @y < 10
			@y++
			@popupHeight--

		console.log "popupWindow x=#{@x} y=#{@y}"

		@popupWindowHolder.css
			left:   @x
			top:    @y
			width:  @popupWidth
			height: @popupHeight

		@windowWrapper.css
			left   : 0
			top    : 4
			width  : @popupWidth
			height : @popupHeight - 26 - 5

		if @configurations.scrollable
			setTimeout () =>
				@myScroll.refresh()
			, 100

		@popupWindowHolder.show()
		@isVisible = true

		@emitEvent "resize", [ @popupWidth, @popupHeight ]
		true

	## -------------------------------------------------------------------------------------------------------------
	## internal function to check to see if there is a saved location and move to it
	##
	internalCheckSavedLocation: () =>

		return false

		# location = user.get "PopupLocation_#{@title}", 0
		if @configurations.tableName and @configurations.tableName.length
			location = localStorage.getItem "PopupLocation_#{@configurations.tableName}"
			console.log "Loaded saved PopupLocation_#{@configurations.tableName}: ", location
			if location != null
				location = JSON.parse location
			if location != 0 && location != null
				@x = location.x
				@y = location.y
				@popupHeight = location.h
				@popupWidth = location.w

	## -------------------------------------------------------------------------------------------------------------
	## internal function to save position of the current popup window
	##
	internalSavePosition: () =>
		if @configurations.tableName != null and @configurations.tableName.length
			localStorage.setItem "PopupLocation_#{@configurations.tableName}",
				JSON.stringify
					x: @x
					y: @y
					h: @popupHeight
					w: @popupWidth

	##|
	##|
	addToolbar: (buttonList)=>

		@toolbarHeight = 42

		gid = "pnav" + GlobalValueManager.NextGlobalID()
		@navBar = $ "<div />",
			id: gid
			class : 'popupNavBar'

		@navBar.css
			position : "absolute"
			top      : @windowTitle.height()+6
			left     : 0
			height   : @toolbarHeight
			width    : "100%"

		@popupWindowHolder.append @navBar

		@toolbar = new DynamicNav("#" + gid)
		for button in buttonList
			@toolbar.addElement button
		@toolbar.render()

		@windowBodyWrapperTop.css "top", @windowTitle.height() + 2 + @toolbarHeight
		@windowWrapper.height @popupHeight - @windowTitle.height() - 1 - @toolbarHeight

		true

	## -------------------------------------------------------------------------------------------------------------
	## function to create popup window holder only if keyValue is not defined
	##
	createPopupHolder: () =>

		globalOpenWindowList.push this

		@toolbarHeight = 0

		id   = GlobalValueManager.NextGlobalID()
		html = $ "<div />",
			class: "PopupWindow"
			id:    "popup#{id}"

		@popupWindowHolder = $(html)
		$("body").append @popupWindowHolder

		##|
		##| Title div

		@windowTitle = new WidgetTag "div", "title", "popuptitle#{id}",
			dragable: true

		@windowTitleText = @windowTitle.add "span", "title_text"
		@windowTitleText.html @title

		@windowClose = @windowTitle.add "div", "closebutton", "windowclose#{id}"
		@windowClose.html "<i class='glyphicon glyphicon-remove'></i>"
		@windowClose.el.on "click", () =>
			if @shield? then @shield.remove()
			if @configurations and @configurations.keyValue then @close() else @destroy()

		@popupWindowHolder.append @windowTitle.el

		##|
		##| Body div with IScroll wrapper
		@windowScroll  = $ "<div />",
			class: "scrollcontent"

		@windowWrapper = $ "<div />",
			id: "windowwrapper#{id}"
			class: "scrollable"

		@windowWrapper.append @windowScroll

		if @configurations.resizable
			@resizable = $ "<div />",
				id: "windowResizeHandler#{id}"
				class: "resizeHandle"
			.appendTo @windowWrapper

		@windowBodyWrapperTop  = $ "<div />",
			class: "windowbody"
		.css
			position: "absolute"
			top:      @windowTitle.outerHeight()
			left:     0
			right:    0
			bottom:   0

		.append @windowWrapper

		@popupWindowHolder.append @windowBodyWrapperTop

		##|
		##|  Setup a scroll area within the body
		if @configurations.scrollable
			@myScroll = new IScroll "#windowwrapper#{id}",
				mouseWheel: true
				scrollbars: true
				bounce: false
				resizeScrollbars: false
				freeScroll: @allowHorizontalScroll
				scrollX: @allowHorizontalScroll

		@dragabilly = new Draggabilly "#popup#{id}",
			handle: "#popuptitle#{id}"

		@dragabilly.on "dragStart", (e) =>
			@popupWindowHolder.css "opacity", "0.5"
			return false

		@dragabilly.on "dragMove", (e) =>
			x = @dragabilly.position.x
			y = @dragabilly.position.y
			w = $(window).width()
			h = $(window).height()
			if x + 50 > w then @dragabilly.position.x = w - 50
			if y + 50 > h then @dragabilly.position.y = h - 50
			if x < -50 then @dragabilly.position.x = -50
			if y < 0 then @dragabilly.position.y = 0

			@x = @dragabilly.position.x
			@y = @dragabilly.position.y
			@internalSavePosition()

			return false

		@dragabilly.on "dragStart", (e) =>
			@popupWindowHolder.css "opacity", "0.5"
			return false

		@dragabilly.on "dragEnd", (e) =>
			@popupWindowHolder.css "opacity", "1.0"
			return false

		startX      = 0
		startY      = 0
		startWidth  = 0
		startHeight = 0
		doMove = (e) =>
			@popupWidth = startWidth + e.clientX - startX
			@popupHeight = startHeight + e.clientY - startY
			@popupWindowHolder.width @popupWidth
			@windowWrapper.width @popupWidth
			@popupWindowHolder.height @popupHeight
			@windowWrapper.height @popupHeight - @windowTitle.height() - 1 - @toolbarHeight
			@windowScroll.trigger('resize')

			# console.log "emit [resize]", @popupWidth, @popupHeight, this
			@emitEvent "resize", [ @popupWidth, @popupHeight ]
			true

		stopMove = (e) =>
			$(document).unbind "mousemove", doMove
			$(document).unbind "mouseup", stopMove
			@internalSavePosition()

		@resizable.on "mousedown", (e) =>
			startX = e.clientX
			startY = e.clientY
			startWidth = @popupWindowHolder.width()
			startHeight = @popupWindowHolder.height()
			$(document).on 'mousemove', doMove
			$(document).on "mouseup", stopMove


	## -------------------------------------------------------------------------------------------------------------
	## constructor create new popup window
	##
	## @param [String] title the window title
	## @param [Integer] x the adjusted X location to open
	## @param [Integer] y the adjusted Y location to open
	## @param [Object] configurations the configurations about the table if popup is savable
	##
	constructor: (@title, @x, @y, configurations) ->

		if typeof @x == "undefined" or @x < 0 then @x = 0
		if typeof @y == "undefined" or @y < 0 then @y = 0

		GlobalClassTools.addEventManager(this)

    	##| check the new passed configurations object and extract values from it
		if !configurations? or typeof configurations != 'object'
			configurations = {}

		if !configurations.scrollable?
			configurations.scrollable = true

		@configurations = $.extend(@configurations,configurations);
		if @configurations.w and @configurations.w > 0 then @popupWidth  = @configurations.w
		if @configurations.h and @configurations.h > 0 then @popupHeight = @configurations.h

		@internalCheckSavedLocation();
		@createPopupHolder()

		##|
		##|  Setup with default sizeing
		@resize @popupWidth, @popupHeight
		true

	## -------------------------------------------------------------------------------------------------------------
	## Set the contents of the window
	##
	## @param [String] new html contents
	html: (strHtml) =>
		@windowScroll.html strHtml
		setTimeout @update, 10
		true

	## -------------------------------------------------------------------------------------------------------------
	## Change the title of the window
	##
	## @param [String] new html contents
	setTitle: (strHtml) =>
		@windowTitleText.html strHtml
		true

	## -------------------------------------------------------------------------------------------------------------
	## Set the background color for the scrollable window area
	## @param [String] color css text
	setBackgroundColor: (colorCss) =>
		@windowWrapper.css "backgroundColor", colorCss


$ ->

	$(document).on "keyup", (e)=>
		if e.keyCode == 27
			if globalOpenWindowList? and globalOpenWindowList.length > 0
				win = globalOpenWindowList.pop()
				console.log "Escape closing window:", win
				win.destroy()
