#!/usr/bin/lua5.2
local hpdf = require "hpdf"

local alldata = { fr = require("data-fr"), en = require("data-en") }
local titles = {
	fr = {
		experience = "Experience",
		projects = "Projets personnel",
		knowledge = "Savoir faire",
		scholar = "Education",
		contests = "Concours",
		languages = "Langues",
		hobbies = "Interets",
		travel = "Voyages",
		references = "References"
	},
	en = {
		experience = "Relevant Experience",
		projects = "Personal projects",
		knowledge = "Knowledge",
		scholar = "Scholarship",
		contests = "Contests",
		languages = "Langues",
		hobbies = "Hobbies",
		travel = "Travel",
		references = "References"
	}
}

local language = "fr"
local data = alldata[language]
local tdata = titles[language]
print("generating PDF")

-- Init HaruPDF
local pdf = hpdf.New()
if not pdf then os.exit(1) end

function getFont(font)
	return hpdf.GetFont(pdf, hpdf.LoadTTFontFromFile(pdf, "/usr/share/fonts/truetype/lato/Lato-"..font..".ttf", true))
end

-- Lato font init
local fonts = {
	regular = getFont("Regular"),
	light = getFont("Light"),
	bold = getFont("Bold"),
	black = getFont("Black")
}

-- Init first page
local page = hpdf.AddPage(pdf)
local height = hpdf.Page_GetHeight(page)
local width = hpdf.Page_GetWidth(page)

-- Draw header separator
hpdf.Page_Rectangle(page, 375, height-165, 3, 120)
hpdf.Page_Fill(page)

-- Begin text & write header
hpdf.Page_BeginText(page)
hpdf.Page_SetFontAndSize(page, fonts.black, 16)
hpdf.Page_TextOut(page, 240, height-60, data.name:upper())
hpdf.Page_SetFontAndSize(page, fonts.light, 12)
hpdf.Page_TextOut(page, 300, height-70, "aka. "..data.nickname)
hpdf.Page_EndText(page)
hpdf.Page_BeginText(page)
hpdf.Page_SetFontAndSize(page, fonts.regular, 12)
hpdf.Page_TextOut(page, 380, height-55, data.address)
hpdf.Page_TextOut(page, 380, height-65, data.city)
hpdf.Page_TextOut(page, 380, height-75, data.country)
hpdf.Page_TextOut(page, 380, height-95, data.phone)
hpdf.Page_TextOut(page, 380, height-105, data.email)
hpdf.Page_TextOut(page, 380, height-125, data.citizenship)
hpdf.Page_TextOut(page, 380, height-135, data.birthdate)
hpdf.Page_TextOut(page, 380, height-155, data.github)
hpdf.Page_TextOut(page, 380, height-165, data.linkedin)

-- Text formatting
local format = {
	header = { size = 16, font = fonts.bold },
	title = { size = 10, font = fonts.bold },
	description = { size = 10, font = fonts.regular }
}

-- Text spacing
local spacing = {
	header = 15,
	title = 12,
	description = 15,
	newbloc = 20,
	newline = 5,
	newoneline = 15,
	newpage = 70
}

-- Text position
local tx = 50
local ty = 225
local tp = hpdf.Page_GetCurrentTextPos(page)

function printHeader(text)
	printText(function() return text:upper() end, format.header, spacing.header)
end

function printText(text, format, spacing)
	hpdf.Page_SetFontAndSize(page, format.font, format.size)
    hpdf.Page_TextOut(page, tx, height-ty, text())
    ty = ty + spacing
end

-- Add experience
printHeader(tdata.experience)
for j, exp in ipairs(data.experience) do
	printText(function() return exp[1]..", "..exp[2].." // "..exp[3].." - "..exp[4] end, format.title, spacing.title)
	for jj, expDetail in ipairs(exp[5]) do
		printText(function() return expDetail end, format.description, spacing.description)
	end
	if next(data.experience, j) then
		ty = ty + spacing.newline
	end
end
ty = ty + spacing.newbloc

-- Add Personal Projects
printHeader(tdata.projects)
for j, dat in ipairs(data.projects) do
    printText(function() return dat[1]..", " end, format.title, 0)
    tp  = hpdf.Page_GetCurrentTextPos(page)
    tx = tp.x
    printText(function() return dat[2] end, format.description, 0)
    tx = 50
    if next(data.projects, j) then
        ty = ty + spacing.newoneline
    end
end
ty = ty + spacing.description + spacing.newbloc

-- Add knowledge
printHeader(tdata.knowledge)
for j, dat in ipairs(data.knowledge) do
    printText(function() return dat end, format.description, 0)
    if next(data.knowledge, j) then
        ty = ty + spacing.newoneline
    end
end

-- Init second page
page = hpdf.AddPage(pdf)
height = hpdf.Page_GetHeight(page)
width = hpdf.Page_GetWidth(page)
hpdf.Page_BeginText(page)
ty = spacing.newpage

-- Add Scholarship
printHeader(tdata.scholar)
for j, dat in ipairs(data.scholarship) do
    printText(function() return dat[1].." - " end, format.title, 0)
	tp  = hpdf.Page_GetCurrentTextPos(page)
    tx = tp.x
    printText(function() return dat[2] end, format.description, 0)
    tx = 50
	if next(data.scholarship, j) then
		ty = ty + spacing.newoneline
	end
end
ty = ty + spacing.description + spacing.newbloc

-- Add contests
printHeader(tdata.contests)
for j, dat in ipairs(data.contests) do
    printText(function() return dat[2] and dat[1].." ("..dat[2]..") -- "..dat[3] or dat[1].." -- "..dat[3] end, format.title, spacing.title)
    for jj, description in ipairs(dat[4]) do
        printText(function() return description end, format.description, spacing.description)
    end
    if next(data.contests, j) then
        ty = ty + spacing.newline
    end
end
ty = ty + spacing.newbloc

-- Add Languages
printHeader(tdata.languages)
for j, dat in ipairs(data.languages) do
    printText(function() return dat[1].." - " end, format.title, 0)
	tp  = hpdf.Page_GetCurrentTextPos(page)
    tx = tp.x
    printText(function() return dat[2] end, format.description, 0)
    tx = 50
    if next(data.languages, j) then
        ty = ty + spacing.newoneline
    end
end
ty = ty + spacing.description + spacing.newbloc

-- Add knowledge
printHeader(tdata.hobbies)
local hobbies = ""
for j, dat in ipairs(data.hobbies) do
	hobbies = next(data.hobbies,j) and hobbies..dat..", " or hobbies..dat
end
    printText(function() return hobbies end, format.description, 0)
ty = ty + spacing.description
local travel = tdata.travel..": "
for j, dat in ipairs(data.travel) do
    travel = next(data.travel,j) and travel..dat..", " or travel..dat
end
    printText(function() return travel end, format.description, 0)
ty = ty + spacing.description + spacing.newbloc

-- Add References
printHeader(tdata.references)
for j, dat in ipairs(data.references) do
    printText(function() return dat[1]..": "..dat[2] end, format.description, spacing.newline)
	ty = ty + spacing.newoneline
end

-- Save and exit
hpdf.SaveToFile(pdf, "resume.pdf")
hpdf.Free(pdf)
