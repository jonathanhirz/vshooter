import luxe.States;
import luxe.Sprite;
import luxe.Vector;
import luxe.Color;
import phoenix.Texture;
import phoenix.Texture.FilterType;
import luxe.Rectangle;

class MenuState extends State {

    var ship : Sprite;
    var ship_sprite : Texture;
    var title_text : Sprite;

    public function new( _name:String ) {
        super({ name:_name });
    } //new

    override function init() {

    } //init

    override function onenter<T>( _value:T ) {

        if(ship_sprite == null) ship_sprite = Luxe.resources.texture('assets/ship.png');
        ship_sprite.filter_mag = FilterType.nearest;
        if(ship == null) {
            ship = new Sprite({
                texture : ship_sprite,
                name : 'ship',
                pos : new Vector(Luxe.screen.w/2, Luxe.screen.h - ship_sprite.height/2),
                depth : 1,
                // scale : new Vector(4, 4)
            }); //ship
            ship.add(new ShipControls('ship_controls'));
            ship.add(new ShipWeapons('ship_weapons'));
            ship.add(new Collider('ship_collider'));
        } //ship

        title_text = new Sprite({
            pos : new Vector(Luxe.screen.w/2, 110),
            size : new Vector(200, 80),
            color : new Color().rgb(0x1e00d7),
        }); //title_text
        title_text.add(new Collider('title_text_collider'));

    } //onenter

    override function onleave<T>( _value:T ) {

        title_text.visible = false;

    } //onleave

} //MenuState