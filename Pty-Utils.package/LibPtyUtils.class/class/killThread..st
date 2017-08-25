c-functions
killThread: handle
		^ LibC system: 'kill ', handle asString.