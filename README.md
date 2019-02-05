# Steps

- rails new mack-child-blog
- rails g model Post title content:text
- rails db:migrate
- rails g controller posts
- create the files posts/index, show, new, edit, form partial
- add the CRUD code to the posts controllers
- add the resources :posts routes

## styling and create welcome page

- add google font and font awesome to layouts/app

```
	<title>Mackenzie Child - Part Designer, Part Developer</title>
	<link href='//fonts.googleapis.com/css?family=Raleway:400,700' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
  <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track' => true %>
  <%= javascript_include_tag 'application', 'data-turbolinks-track' => true %>
  <%= csrf_meta_tags %>
```

- create shared/nav

```
<header id="main_navigation" class="clearfix">
	<%= link_to "Mackenzie Child", root_path, class: "name" %>
	<nav>
		<%= link_to "Articles", posts_path %>
		<%= link_to "Projects", projects_path %>
		<%= link_to "Contact", new_contact_path %>
		<% if user_signed_in? %>
			<%= link_to "Sign Out", destroy_user_session_path, method: :delete %>
		<% end %>
	</nav>
</header>
```

- create shared/footer

```
<footer id="main_footer">
	<p class="copyright">&copy; <%= Time.current.year %> Mackenzie Child</p>
	<nav>
		<a href="http://twitter.com/mackenziechild" target="_blank"><i class="fa fa-twitter"></i></a>
		<a href="http://dribbble.com/mackenziechild" target="_blank"><i class="fa fa-dribbble"></i></a>
		<a href="http://github.com/mackenziechild" target="_blank"><i class="fa fa-github"></i></a>
	</nav>
</footer>		
```

- add the styles
- rails g controller welcome
- add def index to the welcome_controller

```
<div class="wrapper wrapper_padding clearfix">
	<div class="col-1 about homepage_content">
		<h2>About</h2>
		<hr>
		<p>I'm a designer &amp; developer living in Colorado Springs, Colorado.</p>
		<p>By day I work as a front-end dev / designer at Precision Nutrition, by night I teach how to design &amp; code rails applications at <a href="#">Unicasts</a>.</p>
		<p>You can find me speaking in 140 characters on Twitter, swooshing some pixels on Dribbble, and sharing some code on Github.</p>
	</div>
	<div class="col-2 homepage_content">
		<h2>Stuff I've Written</h2>
		<hr>
		<% @posts.each do |post| %>
			<h3><%= link_to post.title, post %></h3>
			<p class="date"><%= post.created_at.strftime("%A, %b %d") %></p>
		<% end %>
	</div>
	<div class="col-3 homepage_content">
		<h2>Stuff I've Built</h2>
		<hr>
		<% @projects.each do |project| %>
			<h3><%= link_to project.title, project %></h3>
			<p class="date"><%= project.created_at.strftime("%A, %b %d") %></p>
		<% end %>
	</div>
</div>
```

## Markdown and Styling Highlighting

- [twitter share](https://rubyplus.com/articles/4341-Twitter-Share-and-Follow-Buttons-in-Rails-5-App)
- add the gems redcarpet, pygments.rb
- in helpers/application_helper

```
module ApplicationHelper
	class HTMLwithPygments < Redcarpet::Render::HTML
    def block_code(code, language)
      Pygments.highlight(code, lexer: language)
    end
  end
	def markdown(content)
		renderer = HTMLwithPygments.new(hard_wrap: true, filter_html: true)
		options = {
			autolink: true,
      no_intra_emphasis: true,
      disable_indented_code_blocks: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true
		}
		Redcarpet::Markdown.new(renderer, options).render(content).html_safe
	end
end
```

- in show.html.erb

```
	<div id="content">
		<%= markdown @post.content %>
	</div>
```

- create pygments.scss

```
/*
   Some simple Github-like styles, with syntax highlighting CSS via Pygments.
*/

pre{
  background-color: #eee;
  padding: 1.5rem 3.5%;
  margin: 2rem 0;
  -webkit-border-radius: 5px;
  -moz-border-radius: 5px;
  border-radius: 5px;
  overflow: auto;
}
code{
  background-color: #eee;
  padding: 1px 3px;
  -webkit-border-radius: 2px;
  -moz-border-radius: 2px;
  border-radius: 2px;
}

.hll { background-color: #ffffcc }
.c { color: #999988; font-style: italic } /* Comment */
.err { color: #a61717; background-color: #e3d2d2 } /* Error */
.k { color: #000000; font-weight: bold } /* Keyword */
.o { color: #000000; font-weight: bold } /* Operator */
.cm { color: #999988; font-style: italic } /* Comment.Multiline */
.cp { color: #999999; font-weight: bold; font-style: italic } /* Comment.Preproc */
.c1 { color: #999988; font-style: italic } /* Comment.Single */
.cs { color: #999999; font-weight: bold; font-style: italic } /* Comment.Special */
.gd { color: #000000; background-color: #ffdddd } /* Generic.Deleted */
.ge { color: #000000; font-style: italic } /* Generic.Emph */
.gr { color: #aa0000 } /* Generic.Error */
.gh { color: #999999 } /* Generic.Heading */
.gi { color: #000000; background-color: #ddffdd } /* Generic.Inserted */
.go { color: #888888 } /* Generic.Output */
.gp { color: #555555 } /* Generic.Prompt */
.gs { font-weight: bold } /* Generic.Strong */
.gu { color: #aaaaaa } /* Generic.Subheading */
.gt { color: #aa0000 } /* Generic.Traceback */
.kc { color: #000000; font-weight: bold } /* Keyword.Constant */
.kd { color: #000000; font-weight: bold } /* Keyword.Declaration */
.kn { color: #000000; font-weight: bold } /* Keyword.Namespace */
.kp { color: #000000; font-weight: bold } /* Keyword.Pseudo */
.kr { color: #000000; font-weight: bold } /* Keyword.Reserved */
.kt { color: #445588; font-weight: bold } /* Keyword.Type */
.m { color: #009999 } /* Literal.Number */
.s { color: #d01040 } /* Literal.String */
.na { color: #008080 } /* Name.Attribute */
.nb { color: #0086B3 } /* Name.Builtin */
.nc { color: #445588; font-weight: bold } /* Name.Class */
.no { color: #008080 } /* Name.Constant */
.nd { color: #3c5d5d; font-weight: bold } /* Name.Decorator */
.ni { color: #800080 } /* Name.Entity */
.ne { color: #990000; font-weight: bold } /* Name.Exception */
.nf { color: #990000; font-weight: bold } /* Name.Function */
.nl { color: #990000; font-weight: bold } /* Name.Label */
.nn { color: #555555 } /* Name.Namespace */
.nt { color: #000080 } /* Name.Tag */
.nv { color: #008080 } /* Name.Variable */
.ow { color: #000000; font-weight: bold } /* Operator.Word */
.w { color: #bbbbbb } /* Text.Whitespace */
.mf { color: #009999 } /* Literal.Number.Float */
.mh { color: #009999 } /* Literal.Number.Hex */
.mi { color: #009999 } /* Literal.Number.Integer */
.mo { color: #009999 } /* Literal.Number.Oct */
.sb { color: #d01040 } /* Literal.String.Backtick */
.sc { color: #d01040 } /* Literal.String.Char */
.sd { color: #d01040 } /* Literal.String.Doc */
.s2 { color: #d01040 } /* Literal.String.Double */
.se { color: #d01040 } /* Literal.String.Escape */
.sh { color: #d01040 } /* Literal.String.Heredoc */
.si { color: #d01040 } /* Literal.String.Interpol */
.sx { color: #d01040 } /* Literal.String.Other */
.sr { color: #009926 } /* Literal.String.Regex */
.s1 { color: #d01040 } /* Literal.String.Single */
.ss { color: #990073 } /* Literal.String.Symbol */
.bp { color: #999999 } /* Name.Builtin.Pseudo */
.vc { color: #008080 } /* Name.Variable.Class */
.vg { color: #008080 } /* Name.Variable.Global */
.vi { color: #008080 } /* Name.Variable.Instance */
.il { color: #009999 } /* Literal.Number.Integer.Long */
```

## Deploy to heroku

- heroku create
- in gemfile

```
group :development do
	gem 'sqlite3'
end
group :production do
	gem 'pg'
	gem 'rails_12factor'
end
```

- bundle
- git push
- git push heroku master
- heroku run rake db:migrate
- heroku restart

## Add Disqus comments

- go to disqus/admin/create
- give a name to the site
- choose universal code
- copy the code
- create posts/disqus partial
- in show.html add the partial

```
<%= render 'disqus' %>
```

- add the variables to the disqus

```
<div id="disqus_thread"></div>
<script>

/**
*  RECOMMENDED CONFIGURATION VARIABLES: EDIT AND UNCOMMENT THE SECTION BELOW TO INSERT DYNAMIC VALUES FROM YOUR PLATFORM OR CMS.
*  LEARN WHY DEFINING THESE VARIABLES IS IMPORTANT: https://disqus.com/admin/universalcode/#configuration-variables*/
/*
var disqus_config = function () {
this.page.url = PAGE_URL;  // Replace PAGE_URL with your page's canonical URL variable
this.page.identifier = PAGE_IDENTIFIER; // Replace PAGE_IDENTIFIER with your page's unique identifier variable
};
*/

var disqus_shortname = 'bloggingcourse'; // required: replace example with your forum shortname
var disqus_identifier = '<%= @post.id %>';
var disqus_title = '<%= @post.title %>';
var disqus_url = '<%= post_url(@post) %>';


(function() { // DON'T EDIT BELOW THIS LINE
var d = document, s = d.createElement('script');
s.src = 'https://blogtemp.disqus.com/embed.js';
s.setAttribute('data-timestamp', +new Date());
(d.head || d.body).appendChild(s);
})();
</script>
<noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
                            
```

## add Friendly ID

- add friendly_id gem
- rails generate friendly_id
- rails g migration add_slug_to_posts slug:string:uniq
- rails db:migrate
- in post.rb

```
class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
end

```

- update the show in posts_controller

```
  def find_post
    @post = Post.friendly.find(params[:id])
  end
```

- in rails c

```
Post.find_each(&:save)
```

- git heroku push
- heroku run rake db:migrate
- heroku run rails c


```
Post.find_each(&:save)
```

## Pagination

- add the will paginate gem
- bundle
- in posts_controller update the index

```
  def index
    @posts = Post.all.order("created_at desc").paginate(page: params[:page], per_page: 10)
  end
```

- udpate index.html.erb

```
<h1 id="page_title">Stuff I've Written</h1>

<div id="posts_wrapper" class="skinny_wrapper">
	<% @posts.each do |post| %>
		<div class="post">
			<p class="date"><%= post.created_at.strftime('%A, %B %d') %></p>
			<h2><a href="#"><%= link_to post.title, post %></a></h2>
			<hr>
		</div>
	<% end %>
</div>

<%= will_paginate @posts %>
```

- [setting up strftime](https://www.foragoodstrftime.com/)

## Create projects

- rails g model Project title description:text link
- rails db:migrate
- rails g controller projects
- add the CRUD for projects

## Contact form & sendgrid

- add mail_form gem
- bundle
- restart server
- rails g controller contacts
- in routes

```
resources :contacts, only: [:new, :create]
```

- update contacts_controller

```
class ContactsController < ApplicationController
	def new
		@contact = Contact.new
	end

	def create
		@contact = Contact.new(params[:contact])
    @contact.request = request
    if @contact.deliver
      flash.now[:error] = nil
    else
      flash.now[:error] = 'Cannot send message.'
      render :new
    end
	end
end
```

- create the file models/contact.rb

```
class Contact < MailForm::Base
  attribute :name,      :validate => true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message,   :validate => true
  attribute :nickname,  :captcha  => true

  def headers
    {
      :subject => "Contact Form",
      :to => "buddylee939@hotmail.com",
      :from => %("#{name}" <#{email}>)
    }
  end
end
```

- create the file views/contacts/new.html.erb

```
<h1 id="page_title">Say Hello!</h1>

<div class="skinny_wrapper wrapper_padding">
	<%= form_for @contact do |f| %>
		<%= f.label :name %><br>
		<%= f.text_field :name, required: true %>

		<br>

		<%= f.label :email %><br>
		<%= f.email_field :email, required: true %>

		<br>

		<%= f.label :message %><br>
		<%= f.text_area :message, as: :text %>

		<div class="hidden">
			<%= f.label :nickname %><br>
			<%= f.text_field :nickname, hint: 'leave this field blank' %>
		</div>

		<%= f.submit 'Send Message', class: "button" %>
	<% end %>
</div>
```

- create views/contacts/create.html.erb

```
<h1 id="page_title">Say Hello!</h1>

<div class="skinny_wrapper wrapper_padding">
	<h1>Thank you for your message!</h1>
	<p>I'll get back to you soon.</p>
</div>
```

- sendgrid heroku addon
- heroku addons:create sendgrid
- at the bottom of environments/production.rb

```
  config.action_mailer.default_url_options = { host: 'https://pacific-forest-9589.herokuapp.com' }
  config.action_mailer.delivery_method = :smtp

  ActionMailer::Base.smtp_settings = {
    :address        => 'smtp.sendgrid.net',
    :port           => '587',
    :authentication => :plain,
    :user_name      => ENV['SENDGRID_USERNAME'],
    :password       => ENV['SENDGRID_PASSWORD'],
    :domain         => 'heroku.com',
    :enable_starttls_auto => true
  }
```

- git push heroku master
- it should work

## Devise authentication

-   

<hr>

# Planning our application
1. Answer Questions
	- What are we building?
	- Who are we building it for?
	- What features do we need to have?
2. User Stories
3. Model our Data
4. Think through the pages we need in our app

## Questions

1. What are we building? We are building a personal site. A place where we can blog, share examples of our work, and have people contact us.
2. Who are we building it for? We are building it for ourselves, but also the community. Sharing what we are learning by blogging is a great way to learn for ourselves, but we teach others in the process. Show potential employers that we know what we are doing.
3. What features do we want to have?
	- Posts
		- Create / Edit / Destroy
		- Markdown
		- Syntax highlighting
		- Comments (Disqus)
	- Projects
		- Create / Edit / Destroy
	- Contact
		- Contact form
		- Sendgrid
	- User (Devise)

## User Stories
As a blank, I want to be able to blank, so that blank.
- As a user, I want to be able to create posts so that I can share what I am learning on my blog.
- As a user, I want to be able to edit & destroy posts, so that I can manage my blog.
- As a user, I want to be able to write posts in markdown format so that it’s easy for me to writes posts.
- As a user, I want to be able to highlight the various syntax of code blocks that I share on my blog.
- As a user, I want to show the visitors and potential employers examples of my work, or stuff I’ve built.
- As a user, I want to be able to have visitors contact me through a form on my site.
- As a user, I want visitors to be able to leave comments on my posts.

## Modeling our Data

**Post**
	title:string
	content:string

**Project**
	title:string
	description:text
	link:string

**User**

## Think through the pages we need in our app

- Home
- Posts#index
- Posts#Show
- Projects#index
- Projects#show
- Contact