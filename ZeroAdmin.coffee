window.h = maquette.h

class ZeroAdmin
	constructor: (@title, @pages) ->
		@tables = {}
		@loadDB(0)

	loadDB: (page_num) =>
		table_keys = Object.keys(@pages)
		Page.cmd "dbQuery", ["SELECT "+Object.keys(@pages[table_keys[page_num]][1]).toString()+" FROM "+table_keys[page_num]], (res) =>
			if @pages[table_keys[page_num]][0].file? == false
				@tables[table_keys[page_num]] = res
			if table_keys[page_num + 1]?
				@loadDB(page_num + 1)
			else
				Page.cmd "dbQuery", ["SELECT * FROM JSON"], (json_id_list) =>
					@json_id_list = json_id_list
					ZeroAdmin.projector.append(document.body, ZeroTalkAdmin.render)

	render: =>
		console.log "[ZeroAdmin] ", @tables
		h("div.ZeroAdmin", [
			h("div.aiLeft",
				[h("div.aiPageTitle", {onclick: @updateDB},
					["Update Database"]
				)],
				(h("div.aiPageTitle", {name: page_name, onclick: @pageOnClick, classes: {activePage: @activePage == page_name}},
					[page[0].title]
				) for page_name, page of @pages)
			),
			@renderActivePage() if @activePage?
		])

	renderActivePage: =>
		h("div", {key: @activePage}, [
			h("table.page", {table_name: @activePage},
				[h("tr",
					(h("td", [field_name]) for field_name of @pages[@activePage][1])
				)],
				(@renderRecord(record_num) for record, record_num in @tables[@activePage])
			)
		])

	renderRecord: (record_num) =>
		record = @tables[@activePage][record_num]
		h("tr.record", {record_num: record_num.toString()},
			(@renderField(field_name, record_num) for field_name of @pages[@activePage][1])
		)

	renderField: (field_name, record_num) =>
		field = @tables[@activePage][record_num][field_name]
		h("td.field", {field_name: field_name}, [
			if @pages[@activePage][1][field_name][0] == "textarea"
				h("textarea", {oninput: @onInput}, [field])
			else
				h("input.text", {value: field, oninput: @onInput})
		])

	onInput: (evt) =>
		field_name = $(evt.target).parent().attr("field_name")
		record_num = $(evt.target).parent().parent().attr("record_num")
		table_name = $(evt.target).parent().parent().parent().attr("table_name")
		@tables[table_name][record_num][field_name] = $(evt.target).val()

	updateDB: =>
		for json_id in (id.json_id for id in @json_id_list when id.file_name == "data.json")
			user = @json_id_list.find((id) => id.json_id == json_id).directory
			@updateUserRecords(user, json_id)

	updateUserRecords: (user, json_id) =>
		inner_path = "data/users/#{user}/data.json"
		Page.cmd "fileGet", {"inner_path": inner_path, "required": false}, (data) =>
			data = JSON.parse(data)
			for table_name, table of @tables
				console.log table_name, data[table_name]
				if @pages[table_name][0].parent?
					for child_name, child of data[table_name]
						for user_record, user_record_num in child
							record = table.find((record) => record.added == user_record.added and record.json_id == json_id)
							console.log record	
							for field_name of user_record when record[field_name]?
								data[table_name][child_name][user_record_num][field_name] = record[field_name]
				else
					for user_record, user_record_num in data[table_name]
						record = table.find((record) => record.added == user_record.added and record.json_id == json_id)
						console.log record	
						for field_name of user_record when record[field_name]?
							data[table_name][user_record_num][field_name] = record[field_name]
			Page.cmd "fileWrite", [inner_path, btoa(JSON.stringify(data))]

	pageOnClick: (evt) =>
		console.log "[ZeroAdmin] ", $(evt.target).attr("name")
		@activePage = $(evt.target).attr("name")
		
	@projector: maquette.createProjector(),
	@page: (attr, cont) -> [attr, cont],
	@user: (attr) -> ["user", attr],
	@input: (attr) -> ["input", attr],
	@textarea: (attr) -> ["textarea", attr],
	@select: (attr) -> ["select", attr]

window.ZeroAdmin = ZeroAdmin