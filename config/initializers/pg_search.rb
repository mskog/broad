# typed: strict
PgSearch.multisearch_options = {
	using: {
		tsearch: {prefix: true},
		trigram: {threshold: 0.5}
	}

}
