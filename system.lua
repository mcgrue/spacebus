require "vx"

function extract_significant_digit( x, place )
    return math.floor(x / 10^place) % 10
end

function draw_odometer( number, basex, basey, im, im_white )
    local x, y, n
    
    for i = 0, 13 do
        n = 13 - i
        x = basex
        y = basey
        
        x = x + (i*7)
        y = y - (extract_significant_digit(number, n)*12)
        im:Blit(x, y)
    end

    im_white:Blit(x+7, y)
end

function autoexec()
    vx.SetAppName("Space Bus")

    local bus_hud = vx.Image('assets/bus.gif')
    local starfield = vx.Image('assets/space.png')
    local joystick = vx.Image('assets/joystick.gif')
    local joystick_down = vx.Image('assets/joystick2.gif')
    local numbers_black = vx.Image('assets/blacknumbers.gif')
    local numbers_white = vx.Image('assets/whitenumbers.gif')
    
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
    
    local distance = 7000000000000
    distance = distance + math.random(100000000000, 7000000000000)
    
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
        
        draw_odometer( distance, odo_x, odo_y, numbers_black, numbers_white)
        bus_hud:Blit(bus_x, bus_y)
        
        if vx.key["Enter"].pressed then
            joystick_down:Blit(joy_x, joy_y)
        else
            joystick:Blit(joy_x, joy_y)
        end
        
        distance = distance + math.random(20,45)
        
        vx.ShowPage()
    end
end