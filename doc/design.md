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
  * starter (User)
  * 1..N messages
  * is_public?
* Messages
  * parent
  * is_deleted?
  * owner
  * text
* Tags

# Milestone 1: Users, Organizations, Groups

* Public Home Page **[DONE]**
* Join / Login Pages **[DONE]**
* Member Search Page (Organizations)
* Join an Organization (Static Groups)
* Create an Organization
* Add Member to Board Group
* Member Profile Page
* Admin Membership Management Page

# Milestone 2: Conversations

<TBD>

# FUTURE

* Custom Groups
* Organization / Groups Policy
* Activity
* Notifications
* Events
* Customizable Organization Home Page
