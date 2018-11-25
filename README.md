# boost!

#### An app to set goals and track daily progress against them.

#### Allows users to comment on and support each other's goals, with awards on user and goal pages for longest daily streak, most supportive user, number of achieved goals, and more.

<img src="demo.gif" alt="short demo of app">

## How it works
- Users can create an account to log goals, which consist of an overall goal (e.g. learn Spanish) and a daily goal (e.g. 1 hour Spanish practice)
- Users can then record the days on which they have met their daily goals
- Users can also view others' goals, and leave comments and 'boosts' (likes, hearts or stars)
- There are various awards displayed on user pages or goal pages, including: highest current daily goal streak, highest percentage of daily goals met, record ever daily goal streak, most boosts given, most comments left, most boosts + comments received, and badges for overall goal completion.
- The goal dashboard shows stats on goals and allows them to be sorted by various measures.

## Structure
#### Ruby on Rails in a classic MVC pattern. Devise is used for user authentification.
### Controllers
- **boosts**: for when users want to add 'boosts' (likes/hearts/stars) to other users' goals
- **categories**: displays goals in a category and sorts category by number of goals or name 
- **comments**: allows a user to add comments (hopefully encouraging!) on other users' goals
- **goals**: key controller dealing with the creation of goals, as well as logging of daily goals met
- **users**: creation and editing of users

### Models
- **boosts**: just selects the relevant icon for a boost type
- **calendar**: logic for generating a calendar form with a checkbox for each day to record a daily goal met (working with the goals/calendar view)
- **category**: sorting categories into various scoreboards, e.g. by daily goals met, average daily goals met
- **goal**: key logic for user awards relating to goals, including longest current daily goal streak, longest ever streak
- **user**: logic for other user awards, including most comments given, most boosts given

### Views
Much as one would expect. Notable files:
- **goals/calendar.html.erb** has the form for logging daily goal mets, relying on logic from the calendar model.
- **goals/show.html.erb** displays awards based upon goal completion
- **users/show.html.erb** displays awards based on user social interaction (boosts, comments) as well as goal completion, using a partial in **layouts/_user_awards.html.erb**