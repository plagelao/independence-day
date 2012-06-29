[![Build Status](https://secure.travis-ci.org/plagelao/independence-day.png?branch=master)][travis] [![Dependency Status](https://gemnasium.com/plagelao/independence-day.png?travis)][gemnasium]

##Why?##
A while ago I read the [object on rails book][1] (which I recommend to you).
This is based on the ideas from the book.

##What?##
Independence day is a library to remove dependencies from our classes (no more 'new' uses)

#How?#
The book is about rails, and the author shows some ways to do dependency injection for that framework. Independence day is based in one of them.

Imagine your blog model:

        class Blog < ActiveRecord::Base
        end

and your entry model:

        class Entry < ActiveRecord::Base
        end

We want to create entries from our blog, so we do:

        class Blog < ActiveRecord::Base

          def create_entry *args
            Entry.create args
          end
        end

What the author does to remove the Entry dependency from Blog is the following (more or less):

        class Blog < ActiveRecord::Base

          attr_writer :entries_creator

          def entries_creator
            @entries_creator ||= ->(*args) { Entry.create args }
          end

          def create_entry *args
            @entries_creator.(args)
          end
        end

Then, in my tests I don't need Entry, since I can override the entries creator.

Independence day creates a DSL for this type of dependency injection:

        class Blog < ActiveRecord::Base
          extend Independent::Maker

          add_creator_of :entries

          def create_entry *args
            @entries_creator.(args)
          end
        end

[1]: http://devblog.avdi.org/2011/11/15/early-access-beta-of-objects-on-rails-now-available-2/ "Objects on rails by Avdi Grimm"
