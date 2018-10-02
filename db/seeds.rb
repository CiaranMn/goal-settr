ciaran = User.create(name: "Ciaran")
kay = User.create(name: "Kay")
dan = User.create(name: "Dan")
ed = User.create(name: "Ed")

education = Category.create(name: "Education", description: "Learning for the betterment of oneself")
music = Category.create(name: "Music", description: "Anything to do with learning music")
financial = Category.create(name: "Financial", description: "Saving, investing, budgeting, and anythings else financial")

k_goal1 = Goal.create(name: "Learn Rails", user_id: 2, description: "Learning rails is fun and useful.", overall_goal: "Rails Master", due_date: Date.parse('07/12/2018'), daily_goal: "Do 5 labs", category: education)

c_goal = Goal.create(name: "Learn Piano", user_id: 1, description: "Learning piano is fun and useful.", overall_goal: "Grade 6 Piano", due_date: Date.parse("31/03/2019"), daily_goal: "30 minutes practice", category: music)

c_goal2 = Goal.create(name: "Learn Javascript", user_id: 1, description: "Getting ready for mod 3", daily_goal: "30 minutes javascript learning", category: education)

cmt1 = Comment.create(commenter_id: 1, goal_id: 1, content: "Fantastic job!")
cmt2 = Comment.create(commenter_id: 2, goal_id: 2, content: "Keep it up!")
cmt3 = Comment.create(commenter_id: 3, goal_id: 1, content: "You can do it!")
cmt4 = Comment.create(commenter_id: 4, goal_id: 2, content: "I believe in you!")
cmt3 = Comment.create(commenter_id: 3, goal_id: 3, content: "Good progress!")

boost1 = Boost.create(booster_id: 1, goal_id: 1)
boost2 = Boost.create(booster_id: 2, goal_id: 2)
boost3 = Boost.create(booster_id: 3, goal_id: 3)
boost4 = Boost.create(booster_id: 3, goal_id: 2)
boost5 = Boost.create(booster_id: 4, goal_id: 1)
boost6 = Boost.create(booster_id: 4, goal_id: 1)

dgm1 = DailyGoalMet.create(goal_id: 1, date: Date.parse('01/10/2018'))
dgm2 = DailyGoalMet.create(goal_id: 1, date: Date.parse('02/10/2018'))
dgm3 = DailyGoalMet.create(goal_id: 1, date: Date.parse('03/10/2018'))
dgm4 = DailyGoalMet.create(goal_id: 1, date: Date.parse('05/10/2018'))
dgm5 = DailyGoalMet.create(goal_id: 1, date: Date.parse('06/10/2018'))
dgm6 = DailyGoalMet.create(goal_id: 1, date: Date.parse('07/10/2018'))
dgm7 = DailyGoalMet.create(goal_id: 1, date: Date.parse('09/10/2018'))
dgm8 = DailyGoalMet.create(goal_id: 1, date: Date.parse('10/10/2018'))
dgm9 = DailyGoalMet.create(goal_id: 2, date: Date.parse('30/09/2018'))
dgm10 = DailyGoalMet.create(goal_id: 2, date: Date.parse('01/10/2018'))
dgm11 = DailyGoalMet.create(goal_id: 2, date: Date.parse('02/10/2018'))
dgm12 = DailyGoalMet.create(goal_id: 2, date: Date.parse('03/10/2018'))
dgm13 = DailyGoalMet.create(goal_id: 2, date: Date.parse('04/10/2018'))
dgm14 = DailyGoalMet.create(goal_id: 2, date: Date.parse('01/10/2018'))
