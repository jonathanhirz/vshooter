import luxe.Input;
import luxe.Vector;
import luxe.Sprite;
import luxe.Color;
import luxe.utils.Maths;
import phoenix.Texture;
import luxe.Rectangle;
import luxe.States;
import luxe.GameConfig;

class Main extends luxe.Game {

    var machine : States;
    var star_sprite : Texture;
    var number_of_stars : Int = 50;
    public static var bounds : Rectangle;

    override function config( config:luxe.GameConfig ) {

        config.preload.textures.push({ id:'assets/star.png' });
        config.preload.textures.push({ id:'assets/ship.png' });
        config.preload.textures.push({ id:'assets/beam.png' });

        return config;

    } //config

    override function ready() {

        bounds = new Rectangle(0,0,Luxe.screen.w, Luxe.screen.h);
        connect_input();
        //TODO: zoom fix so I can see gameplay on my macbook air. remove for builds
        // Luxe.camera.zoom = 0.75;
        machine = new States({ name:'statemachine' });
        machine.add(new MenuState('menu_state'));
        machine.add(new PlayState('play_state'));
        machine.set('menu_state');

        create_starfield();

    } //ready

    override function onkeyup( e:KeyEvent ) {

        if(e.keycode == Key.escape) {
            Luxe.shutdown();
        }

    } //onkeyup

    override function update( dt:Float ) {

        //do collision check
        //in menu_state first, check for 3 collisions with title_text
        //when title destroyed, switch to play_state (which loads enemies, etc)
        // go play

    } //update

    function create_starfield() {
        star_sprite = Luxe.resources.texture('assets/star.png');
        for(i in 0...number_of_stars) {
            var star = new Sprite({
                name : 'star'+i,
                texture : star_sprite,
                pos : new Vector(Luxe.utils.random.int(0, Luxe.screen.w), Luxe.utils.random.int(0, Luxe.screen.h)),
                depth : 0
            }); //star
            star.add(new Star());
        }

    } //create_starfield

    function connect_input() {

        Luxe.input.bind_key('up', Key.up);
        Luxe.input.bind_key('up', Key.key_w);
        Luxe.input.bind_key('right', Key.right);
        Luxe.input.bind_key('right', Key.key_d);
        Luxe.input.bind_key('down', Key.down);
        Luxe.input.bind_key('down', Key.key_s);
        Luxe.input.bind_key('left', Key.left);
        Luxe.input.bind_key('left', Key.key_a);
        Luxe.input.bind_key('fire', Key.space);
        Luxe.input.bind_key('toggle_collider', Key.key_t);

    } //connect_input

} //Main
