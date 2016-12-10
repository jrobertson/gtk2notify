#! /usr/bin/env ruby

# file: gtk2notify.rb

require 'gtk2svg'


# note: If calling this from within an EventMachine defer statement it 
#       may be necessary to call it through a system call e.g. 
#         `ruby -r gtk2notify -e "GtkNotify.show body: 'Testing this works'"`

class GtkNotify

  def self.show(svg: nil, body: 'message body goes here', summary: '', 
                                        timeout: 3.5, offset: {})

    offset = {x: 100, y: 10}.merge offset

    window = Gtk::Window.new    
    area = Gtk::DrawingArea.new    
    
    svg ||= <<SVG
<svg width="350" height="80" fill="yellow">
   <text x="20" y="10" fill="green" style="font-size: 14">
      #{body.gsub(/<\/?\w+[^>]*>/,'')}
   </text>
</svg>
SVG
    doc = Svgle.new(svg, callback: self)
    a = Gtk2SVG::Render.new(doc).to_a
    
    area.signal_connect("expose_event") do            
      drawing = Gtk2SVG::DrawingInstructions.new area
      drawing.render a
    end

    svg_width, svg_height = %i(width height).map{|x| doc.root.attributes[x].to_i }
    
    if svg_width and svg_height then
      window.set_default_size(svg_width, svg_height)
    end    
    
    window.add(area).show_all

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

  GtkNotify.show body: ARGV.inspect, offset: {x: 120} 

end
