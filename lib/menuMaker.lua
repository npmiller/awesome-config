--Creates an app menu for awesome
--{{

appfolder = "/usr/share/applications/"
menuFile = os.getenv("XDG_CONFIG_HOME") .. "/awesome/appMenu.lua"
config = os.getenv("XDG_CONFIG_HOME")
terminal = "urxvtc"


categories = { "Settings" , "System" , "Network" , "Development" , "Utility" , "Office" , "AudioVideo" , "Graphics" , "Game" , "Others" }

--List all the .desktop files
--{{
function list(appfolder)
	local f = io.popen("ls " .. appfolder)
	local files = { }
	local t=true

	while t do
		line=f:read("*line")
		if line==nil then
			t=false
		elseif string.match(line,".desktop") then
			table.insert(files,appfolder..line)
		end
	end
	f:close()
	return files
end
--}}

--Extract useful data from a .desktop file
--{{
function getData(file)
	local f = assert(io.open(file,"r"))
	local data = { }
	local t=true

	while t do
		line = f:read("*line")
		if line==nil then
			t=false
		elseif string.match(line,"^Name=") then
			data[1]=string.sub(line,6,-1)
		elseif string.match(line,"^Exec=") then
			data[2]=string.sub(line,6,-1)
		elseif string.match(line,"^Terminal=") then
			data[3]=string.sub(line,10,-1)
		elseif string.match(line,"^Categories=") then
			data[4]=string.sub(line,12,-1)
		end
	end
	f:close()
	return data
end
--}}

--Put every application in the good category
--{{
function classify(datas,categories)
	classified = { }
	for k=1,#categories do
		classified[k] = { }
	end

	for j=1,#datas do
		for i=1,(#categories-1) do
			if datas[j][4] == nil then
				table.insert(classified[#categories],datas[j])
				break
			elseif string.match(datas[j][4],categories[i]) then
				table.insert(classified[i],datas[j])
				break
			elseif i==9 then
				table.insert(classified[#categories],datas[j])
			end
		end
	end
	return classified
end
--}}

--Format the exec part
--{{
function setExec(datas)
	for i=1,#datas do
		if datas[i][3]=="true" then
			datas[i][2]="'"..terminal .. ' -e ' .. datas[i][2] .. "'"
		else
			datas[i][2]="'"..datas[i][2].."'"
		end
	end
end
--}}


--Make an awesome Menu from 2 tables
--{{
function makeMenu(names,actions)
	local menu=''

	for i=1,#names do
		menu=menu .. "{ '" .. names[i] .. "' , " .. actions[i] .. " },\n"
	end
	return menu
end
--}}

--Make the categories Menu--
--{{
function makeCategoriesMenu(categories)
	local menu='categoriesMenu = { \n'
	local subMenu = { }

	for i=1,#categories do
		table.insert(subMenu,"my"..categories[i].."menu")
	end
	menu = menu .. makeMenu(categories,subMenu)
	menu = menu .. "{ 'Actualiser', 'lua " .. config .. "/awesome/lib/menuMaker.lua'},\n }"
	return menu
end
--}}

--Make app menus
--{{
function makeAppMenu(datas)
	local menu=''

	for i=1,#datas do
		menu=menu .. "{ '" .. datas[i][1] .. "' , " .. datas[i][2] .. " },\n"
	end
	return menu
end
--}}

--Creates the Menu
--{{
files = list(appfolder)
datas = { }
for i=1,#files do
	table.insert(datas,getData(files[i]))
end
setExec(datas)
classified = classify(datas,categories)
finalMenu = makeCategoriesMenu(categories)
for i=1,#categories do
	finalMenu = "my"..categories[i].."menu = { \n" .. makeAppMenu(classified[i]) .. "}\n" .. finalMenu
end
--}}

--Write it into a file
--{{
f = assert(io.open(menuFile,"w"))
f:write(finalMenu)
f:close()
--}}
--}}
