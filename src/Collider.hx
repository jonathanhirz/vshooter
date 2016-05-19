import luxe.Component;
import luxe.Sprite;
import luxe.Vector;
import luxe.Color;
import luxe.collision.shapes.*;
import luxe.collision.ShapeDrawerLuxe;

class Collider extends Component {

    var sprite : Sprite;
    var sprite_collider : Polygon;
    var shape_drawer : ShapeDrawerLuxe;
    var draw_collider : Bool = false;

    public function new(_name:String) {
        super({ name:_name });
    } //new

    override function init () {

        sprite = cast entity;
        sprite_collider = Polygon.rectangle(sprite.pos.x, sprite.pos.y, sprite.size.x, sprite.size.y);
        sprite_collider.name = name;
        // trace(sprite_collider.name);
        // PlayState.sprite_collider_pool.push(sprite_collider);
        shape_drawer = new ShapeDrawerLuxe();

    } //init

    override function update(dt:Float) {

        sprite_collider.position = sprite.pos;
        sprite_collider.rotation = sprite.rotation_z;
        if(draw_collider) {
            shape_drawer.drawPolygon(sprite_collider);
        }

        if(Luxe.input.inputpressed('toggle_collider')) {
            draw_collider = !draw_collider;
        }

    } //update

} //Collider