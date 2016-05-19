import luxe.Component;
import luxe.Sprite;
import luxe.Vector;

class Beam extends Component {

    var beam : Sprite;
    public var alive : Bool = false;
    var speed : Int = 1000;

    public function new(_name:String) {
        super({ name:_name });
    } //new

    override function init() {

        beam = cast entity;

    } //init

    override function update(dt:Float) {

        if(!Main.bounds.point_inside(beam.pos)) {
            kill_beam();
        }

        if(alive) {
            beam.pos.y -= speed * dt;
        }

    } //update

    function kill_beam() {

        alive = false;
        beam.visible = false;

    } //killl_beam


} //Beam