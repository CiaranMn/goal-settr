ciaran = User.create(name: "Ciaran")
kay = User.create(name: "Kay")

education = Category.create(name: "Education", description: "Learning for the betterment of oneself")

music = Category.create(name: "Music", description: "Anything to do with learning music")

k_goal = Goal.create(name: "Learn Rails", user_id: 2, description: "Learning rails is fun and useful.", overall_goal: "Rails Master", due_date: 07/12/2018, daily_goal: "Do 5 labs", category: education)

c_goal = Goal.create(name: "Learn Piano", user_id: 1, description: "Learning piano is fun and useful.", overall_goal: "Grade 6 Piano", due_date: 31/03/2019, daily_goal: "30 minutes practice", category: music)

cmt1 = Comment.create(commenter_id: 1, goal_id: 1, content: "Fantastic job!")
cmt2 = Comment.create(commenter_id: 2, goal_id: 2, content: "Keep it up!")

boost1 = Boost.create(booster_id: 1, goal_id: 1)
boost2 = Boost.create(booster_id: 2, goal_id: 2)
