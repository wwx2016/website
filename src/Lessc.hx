package;

class Lessc{

  static function build() {
    Sys.command('lessc', ['src/styles.less', 'bin/assets/styles.css']);
  }
  
}