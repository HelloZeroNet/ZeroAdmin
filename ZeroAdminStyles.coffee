$("body").append("""
<style>
.ZeroAdmin {
	padding: 10px;
	padding-left: 210px;
	background: white; 
	position: fixed; 
	top: 0px; 
	left: 0px; 
	bottom: 0px; 
	right: 0px; 
	overflow: auto;
}

.aiLeft {
	position: fixed;
	top: 0;
	bottom: 0;
	left: 0;
	width: 200px;
	margin: 0px !important;
	padding: 0px;
	background-color: #212121;
	-webkit-box-shadow: rgba(0, 0, 0, 0.156863) 0px 3px 10px, rgba(0, 0, 0, 0.227451) 0px 3px 10px;
	-moz-box-shadow: rgba(0, 0, 0, 0.156863) 0px 3px 10px, rgba(0, 0, 0, 0.227451) 0px 3px 10px;
	box-shadow: rgba(0, 0, 0, 0.156863) 0px 3px 10px, rgba(0, 0, 0, 0.227451) 0px 3px 10px;
}

.aiPageTitle {
	border: none;
	color: #FAFAFA !important;
	font-family: 'Roboto', sans-serif !important;
	font-weight: normal;
	display: block !important;
	margin: 0px;
	padding: 16px;
	line-height: 100% !important;
}

.aiPageTitle:hover {
    background-color: black;
}

table {
	border-spacing: 1px;
	font-family: Roboto, sans-serif;
	color: #212121;
	font-size: 16px;
	background: #F5F5F5;
	margin: 0px;
}

table tr {
	text-align: center;
}

table tr td {
	background: #FAFAFA;
	padding: 8px;
}

tr:first-child td{ 
	line-height: 100% !important;
    padding: 16px;
}

table tr:hover td{
	background: #F5F5F5;
}
</style>
""")