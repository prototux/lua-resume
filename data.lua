local data = {}

data.name = "John Doe"
data.nickname = "jojo"
data.address = "42 sesame street"
data.city = "NYC"
data.country = "USA"
data.phone = "+33 2 42 42 42 42"
data.email = "john.doe@example.org"
data.citizenship = "World citizen"
data.birthdate = "Epoch years - 01/01/1970"
data.github = "https://www.github.com/johndoe"
data.linkedin = "https://www.linkedin.com/in/johndoe"

data.experience =  { -- { company name, Location, Dates, Description[] }
	{ "Example inc", "Springfield", "January 2001", "April 2050", {"Did some work in a nuclear reactor", "Replaced duffman as Cogip' mascot"} }
}

data.contests = { -- { Contest name, additional details, Date, Description }
    { "Beer contest", "Heavyweight", "June 2005", { "Won the blue ribbon.", "Broke the record with 50 liters.", "I don't remember the details for some reason" }},
}

data.projects = { -- { Project name, Description }
    { "Doh", "I like to say that so much i've created a device that say it for me" },
}

data.scholarship = { -- { School/Diploma name, Date }
    { "Krusty university", "Nuclear physics" },
}

data.knowledge = { -- { Languages, Libraries, Sysadmin, Tools, Other }
	"Watching TV, eating donuts"
}

data.languages = { -- { Language, Level }
    { "English", "Doh!" }
}

data.hobbies = { -- { Name }
    "Duff", "Spider pigs", "Donuts", "Myhbusters wrecking ball"
}

data.travel = { -- { Country name }
	"USA! USA! USA!"
}

data.references = { -- { Name, Link }
    { "Duff certified", "http://example.org/duff_certification" }
}


return data
