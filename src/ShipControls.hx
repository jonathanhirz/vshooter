import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Input;
import luxe.utils.Maths;

class ShipControls extends Component {

    var ship : Sprite;
    var h_velocity : Float = 0;
    var v_velocity : Float = 0;
    var h_acceleration : Float = 0;
    var v_acceleration : Float = 0;
    var velocity_max : Float = 15;
    var acceleration_speed : Int = 15;
    var dampening_amount : Float = 0.95;
    var cancel_dampening_amount : Float = 0.85;
    

    public function new(_name:String) {
        super({ name:_name });
    } //new
    
    override function init() {

        ship = cast entity;

    } //init

    override function update(dt:Float) {

        // if we are below max velocity, add acceleration to velocity each frame
        if(Math.abs(h_velocity) < velocity_max) h_velocity += h_acceleration * dt;
        if(Math.abs(v_velocity) < velocity_max) v_velocity += v_acceleration * dt;

        // move the ship based on velovity
        ship.pos.x += h_velocity;
        ship.pos.y += v_velocity;

        // basic 4 way movement, set acceleration in movement direction, cancel movement in opposite direction
        if(Luxe.input.inputdown("left")) {
            if(h_velocity > 0) h_velocity *= cancel_dampening_amount;
            h_acceleration = -acceleration_speed;
        }
        if(Luxe.input.inputdown("right")) {
            if(h_velocity < 0) h_velocity *= cancel_dampening_amount;
            h_acceleration = acceleration_speed;
        }
        if(Luxe.input.inputdown("up")) {
            if(v_velocity > 0) v_velocity *= cancel_dampening_amount;
            v_acceleration = -acceleration_speed;
        }
        if(Luxe.input.inputdown("down")) {
           if(v_velocity < 0) v_velocity *= cancel_dampening_amount;
            v_acceleration = acceleration_speed;
        }

        // stop movement if opposite keys are pressed, or if neither direction is pressed
        // gotta love that combined AND/OR logic...
        if((!Luxe.input.inputdown("left") && !Luxe.input.inputdown("right")) || (Luxe.input.inputdown("left") && Luxe.input.inputdown("right"))) {
            h_acceleration = 0;
            h_velocity *= dampening_amount;
        }
        if((!Luxe.input.inputdown("up") && !Luxe.input.inputdown("down")) || (Luxe.input.inputdown("up") && Luxe.input.inputdown("down"))) {
            v_acceleration = 0;
            v_velocity *= dampening_amount;
        }

        // if velocity drops below a small amount, set it to zero. Need this because of dampening and very very tiny floats
        if(Math.abs(v_velocity) < 0.05) v_velocity = 0.0;
        if(Math.abs(h_velocity) < 0.05) h_velocity = 0.0;

        // keep that ship on screen
        ship.pos.x = Maths.clamp(ship.pos.x, ship.size.x/2, Luxe.screen.w - ship.size.x/2);
        ship.pos.y = Maths.clamp(ship.pos.y, ship.size.y/2, Luxe.screen.h - ship.size.y/2);

    } //update


} //ShipControls
