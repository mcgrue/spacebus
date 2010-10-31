require "vx"

function draw_odometer( number, basex, basey, im )
    local x, y
    
    for i = 0, 13 do
        x = basex
        y = basey
        
        x = x + (i*7)
        im:Blit(x, y)
    end 
end

function autoexec()
    local bus_hud = vx.Image('assets/bus.gif')
    local starfield = vx.Image('assets/space.png')
    local joystick = vx.Image('assets/joystick.gif')
    local joystick_down = vx.Image('assets/joystick2.gif')
    local numbers_black = vx.Image('assets/blacknumbers.gif')
    
    local orig_bus_x = -32
    local orig_bus_y = 0
    local bus_x = 0
    local bus_y = 0    
    local orig_joy_x = 70
    local orig_joy_y = 220
    local joy_x = 0
    local joy_y = 0
    local original_odo_x = 195
    local original_odo_y = 247
    local odo_x = 0
    local odo_y = 0
    
    while true do
        vx.screen:RectFill(0, 0, vx.screen.width, vx.screen.height, vx.RGB(0, 0, 255))
        
        starfield:Blit(0, 0)
        
        bus_x = orig_bus_x
        bus_y = orig_bus_y
        
        joy_x = orig_joy_x
        joy_y = orig_joy_y
        
        odo_x = bus_x + original_odo_x
        odo_y = bus_y + original_odo_y
        
        if vx.key["Up"].pressed then
            joy_y = joy_y - 32
        elseif vx.key["Down"].pressed then
            joy_y = joy_y + 32
        elseif vx.key["Left"].pressed then
            joy_x = joy_x - 32
        elseif vx.key["Right"].pressed then
            joy_x = joy_x + 32
        end
        
        draw_odometer( 1234567890123.5, odo_x, odo_y, numbers_black)
        bus_hud:Blit(bus_x, bus_y)
        
        if vx.key["Enter"].pressed then
            joystick_down:Blit(joy_x, joy_y)
        else
            joystick:Blit(joy_x, joy_y)
        end
        
        vx.ShowPage()
    end
end