$ ->
	window.location.search.replace /[?&]+([^=&]+)=([^&]*)/gi, (str, key, value) =>
		if key == "page" and value == "ZeroAdmin"
			window.ZeroTalkAdmin = new ZeroAdmin "ZeroTalkAdmin", {
				"topic": ZeroAdmin.page({title:"Topics", orderby: "added DESC"}, {
					"json_id": ZeroAdmin.user({title: "Username", disabled: 1, save: 0}),
					"added": ZeroAdmin.input({formatter: Date.toDate, deformatter: Date.fromDate}),
					"title": ZeroAdmin.input(),
					"body": ZeroAdmin.textarea(),
					"type": ZeroAdmin.select({values: ["", "group"]}),
					"parent_topic_uri": ZeroAdmin.select({title: "Parent topic", values: ""})
				}),
				"comment": ZeroAdmin.page({title:"Comments", orderby: "added DESC", parent: "topic"}, {
					"json_id": ZeroAdmin.user({title: "Username", disabled: 1, save: 0}),
					"added": ZeroAdmin.input({formatter: Date.toDate, deformatter: Date.fromDate}),
					"body": ZeroAdmin.textarea(),
					"topic_uri": ZeroAdmin.select({title: "Topic", values: ""})
				}), 
				"settings": ZeroAdmin.page({title:"Settings", file: "content.json"}, {
					"settings.admin": ZeroAdmin.input({title: "Admin name"}),
					"settings.href": ZeroAdmin.input({title: "Admin contact url"}),
					"settings.sticky_uris": ZeroAdmin.select({title: "Sticky topic uris", multi: 1, values: ""})
				})
			}