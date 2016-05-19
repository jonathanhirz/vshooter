import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Color;
import luxe.utils.Maths;

class Star extends Component {

    var star : Sprite;
    var the_randomness : Float = Luxe.utils.random.float(0.25, 0.75);
    var star_speed : Int = 100;

    override function init() {

        star = cast entity;
        star.scale = new Vector(the_randomness, the_randomness);
        star.color = new Color(1,1,1,the_randomness);

    } //init

    override function update(dt:Float) {

        star.pos.y += star_speed * the_randomness * dt;
        if(star.pos.y > Luxe.screen.h + star.size.y) {
            star.pos.y = -star.size.y;
        }

    } //update

} //Star