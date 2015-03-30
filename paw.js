(function(window){
	var _p = {};

	/**
	 * Check if user has the desktop Paw app installed, and calls `cb` when
	 * completed.
	 * @param cb A callback function.
	 */
	var _chkHasPaw = function(cb) {
		var r = confirm('Do you have Paw?');
		cb(r);
	}

	/**
	 * Opens in Paw with the given parameters object.
	 * @param d The parameters.
	 */
	_p.open = function(d) {
		_chkHasPaw(function(r) {
			if (r) {
				if ('undefined' !== typeof d.deeplink) {
					document.location.href = d.deeplink;
				}
			}
			else {
				document.location.href = 'https://luckymarmot.com/paw';
			}
		});
	}

	window.paw = _p;
})(window);
