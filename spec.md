Requirements
[x]Use the Ruby on Rails framework.

[x]Your models must:

• Include at least one has_many, at least one belongs_to, and at least two has_many :through relationships
• Include a many-to-many relationship implemented with has_many :through associations. The join table must include a user-submittable attribute — that is to say, some attribute other than its foreign keys that can be submitted by the app's user
Your models must include reasonable validations for the simple attributes. You don't need to add every possible validation or duplicates, such as presence and a minimum length, but the models should defend against invalid data.
* User has_many players & tournaments
* Players has many teams through players_teams
* tournament has_many players through teams
* I have two join tables (players_teams, teams)

[x]You must include at least one class level ActiveRecord scope method 
 a. Your scope method must be chainable, meaning that you must use ActiveRecord Query methods (Links to an external site.) within it (such as .where and .order) rather than native ruby methods (such as #find_all or #sort).
 * I have a scope method for players_teams to get records with a certain team_id

[x]Your application must provide standard user authentication, including signup, login, logout, and passwords.

[x]Your authentication system must also allow login from some other service. Facebook, Twitter, Foursquare, Github, etc...
* user facebook

[x]You must include and make use of a nested resource with the appropriate RESTful URLs.
* I have nested resoureces under tournament and under teams
• You must include a nested new route with form that relates to the parent resource
• You must include a nested index or show route
[x]Your forms should correctly display validation errors.
* displays error on top of view and also outlines the field in red dots

a. Your fields should be enclosed within a fieldswitherrors class
b. Error messages describing the validation failures must be present within the view.
[x]Your application must be, within reason, a DRY (Do-Not-Repeat-Yourself) rails app.

• Logic present in your controllers should be encapsulated as methods in your models.
• Your views should use helper methods and partials when appropriate.
• Follow patterns in the Rails Style Guide (Links to an external site.)
[x]Do not use scaffolding to build your project. Your goal here is to learn. Scaffold is a way to get up and running quickly, but learning a lot is not one of the benefits of scaffolding.