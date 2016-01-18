package;

class Lessc{

  static function build() {
    Sys.command('lessc', ['src/styles.less', 'bin/assets/styles.css']);
    Sys.command('haxe', ['-cp', 'src', '-js', 'bin/assets/script.js', '-main', 'Swag']);
  }
  
}