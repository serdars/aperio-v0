# Personas

### Non-Profit

It's a small / medium non-profit.

**Jill:**
She is working at the non-profit. She is one of the main personalities. Maybe Executive Director? Her personal life mostly revolves around the organization and her work. She wants to get more people interested and involved in the organization.

**Hans:**
Hans is at the board of the non-profit. He actively participates to the projects of the non-profit.

**John:**
He is a member of the non-profit, but not a super active one. He has volunteered or joined a few of the meetings or events.

**Jack:**
He is a dude that is bored and looking for something to do. He has been to multiple meetups. He wants to show off what he is doing as everyone else.

# Requirements V1

* Jack can:
  * search for organizations based on his interests.
  * see which organization is more active than others.
  * show off his memberships and activity on his profile page.
  * see the new messages since he lasted checked out.

* Jill can:
  * see the list of members and details of her organization.
  * have different groups in her organization for:
    * Public
    * Board
    * Volunteers
    * Followers
    * ...
  * have custom groups in her organization.

* Hans can:
  * start a conversation with board members.
  * start a conversation with Volunteers.
  * start a conversation with any individual members.
  * start a public conversation.

# Design

Looks like we have:

* Users
  * username
  * password[*]
  * 1..N organizations
  * 1..N organization.groups
  * 1..N messages
  * 1..N conversations
* Groups
  * Invite Only?
  * Messages Public?
* Organizations
  * Name
  * Contact Info: Website / etc...
  * Description
  * 1..N tags
  * Policy (e.g.):
    * public_membership_allowed?
    * default_group_upon_join
    * ...
* Conversations
  * owner (User)
  * to_group
  * 1..N messages
* Messages
  * conversation
  * owner
  * text
* Tags

## Notification System / Timeline

Notifications and Activity will be different tables in the database.
Ideally they will be prepared as a background task but ease we will post
  them with ActiveRecord callback and mass insertion for now.

Example activities:
* Serdar joined Org Name - Group Name on Date.
* Serdar started a conversation on Org Name - Group Name on Date.
* Serdar posted a message to Conversation Name on Date.

* Activity
  * Subject Type
  * Subject ID
  * Action
  * Object Type
  * Object ID
  * Data

* Notification
  * User
  * Subject User
  * Action
  * Object Type
  * Object ID

# Milestone 1: MVP Demo **DONE**
* Public Home Page
* Join / Login Pages
* Home Page: View Organizations
* Organizations / Tags / Seeds for 10 organizations
* Organization Page
* Groups / Static 4 groups per organization
* Join an Organization / Join a Group
* Profile Page
* Private Groups
* Organization Member Mgmt Page
* Add member to a group

# Milestone 2: Conversations

* **DONE**
  * Initial design
  * I can see conversations in the org page
  * Org page utilizes more of the real estate
  * Group page shows the conversations that group is included in
  * Group list hovers and full div is clickable
  * User page has two tabs. Membership / Notifications.
* **TODO**
  * Conversation tab shows the conversations with updates title bold.
  * Header shows the count of "updates" for the user. Clicking takes
    to notifications tab.
  * Users should have a screen name
  * I can start a conversation from org page
  * Message / conversation notifications.
  * Conversation page should be able to reply in the same page.
    * Message editing
  * deleting final message deletes the conversation
  * Users shouldn't see private group related things.

# FUTURE

* Conversations with individuals
* Create organizations
* Create Groups
* Organization / Groups Policy
* Activity
* Notifications
* Events
* Customizable Organization Home Page
* Volunteer Match Crawl
