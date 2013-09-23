rails = (function(exports, global) {
	var datum = exports;
	var defaultSeparator = '.';

	function lookup(query, track) {
		var parts = separateQuery(query),
				part = null,
				messages = datum;
		while(messages) {
			part = parts.shift();
			if (parts.length == 0) break;
			if (track && !messages[parts]) messages[part] = {};
			messages = messages[part];
		}
		return messages;
	}

	function deepMerge(target, source) {
		for(var key in source) {
			if (source.hasOwnProperty(key)) {
				target[key] = source[key];
			}
		}
		return target;
	}

	function separateQuery(query, n) {
		var parts = query.split(defaultSeparator);
		if (n < 0) n += parts.length
		return n ? parts[n] : parts;
	}

	return {
		set: function(name, value) {
			var parent = lookup(name, true);
			if (parent) parent[separateQuery(name, -1)] = value;
		},
		get: function(name) {
			var parent = lookup(name);
			return (parent = lookup(name)) ? parent[separateQuery(name, -1)] : parent;
		},
		values: datum
	}
}(typeof rails === 'undefined' ? {} : rails, this));
