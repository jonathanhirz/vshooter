import luxe.Component;
import luxe.Sprite;
import luxe.Vector;
import phoenix.Texture;

class ShipWeapons extends Component {

    var ship : Sprite;
    var beam_sprite : Texture;
    var ammo_cache : Array<Sprite>;
    var number_of_shots : Int = 10;
    var current_beam : Int = 0;
    var fire_rate : Float = 0.2;
    var next_fire : Float = 0;


    public function new(_name:String) {
        super({ name:_name });
    } //new

    override function init() {

        ship = cast entity;

        ammo_cache = [];
        beam_sprite = Luxe.resources.texture('assets/beam.png');
        for(i in 0...number_of_shots) {
            var beam = new Sprite({
                texture : beam_sprite,
                name : 'beam' + i,
                visible : false, 
                pos : new Vector(Luxe.screen.w/2, Luxe.screen.h)
            }); //beam
            beam.add(new Beam('beam'));
            ammo_cache.push(beam);
        } //for number_of_shots

    } //init

    override function update(dt:Float) {

        if(Luxe.input.inputdown("fire")) {
            fire_weapon();
        } //fire

    } //update

    function fire_weapon() {

        if(Luxe.time > next_fire) {
            if(current_beam > number_of_shots - 1) {
                current_beam = 0;
            }
            var this_shot = ammo_cache[current_beam];
            // this_shot.pos = new Vector(ship.pos.x, ship.pos.y);
            this_shot.pos = ship.pos.clone();
            var this_shot_component : Beam = this_shot.get("beam");
            this_shot_component.alive = true;
            this_shot.visible = true;
            current_beam++;
            next_fire = Luxe.time + fire_rate;
        } //next_fire

    } //fire_weapon


} //ShipWeapons
