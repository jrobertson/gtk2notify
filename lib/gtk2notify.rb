#! /usr/bin/env ruby

# file: gtk2notify.rb

require 'gtk2'


# note: If calling this from within an EventMachine defer statement it 
#       may be necessary to call it through a system call e.g. 
#         `ruby -r gtk2notify -e "GtkNotify.show body: 'Testing this works'"`

class GtkNotify

  def self.show(body: 'message body goes here', summary: '', 
                                        timeout: 2.5, offset: {})

    offset = {x: 30, y: 10}.merge offset

    label = Gtk::Label.new(body)
    window = Gtk::Window.new
    window.add(label).show_all

    window.decorated = false
    window.border_width = 10

    window.gravity = Gdk::Window::GRAVITY_NORTH_EAST
    width, height =  window.size
    x,y = offset[:x], offset[:y]
    window.move(Gdk.screen_width - (width + x), y)

    window.show_all
    Thread.new {sleep timeout; window.hide_all; Gtk.main_quit}

    Gtk.main

  end
end

if __FILE__ == $0 then

  GtkNotify.show body: 'Testing the notification system', offset: {x: 120} 

end
