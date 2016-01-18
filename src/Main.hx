package;
import haxe.io.Bytes;
import haxe.io.Path;
import sys.FileSystem;
import sys.io.File;
using StringTools;

#if foxhole
  import foxhole.Web;
#elseif php
  import php.Web;
#elseif neko
  import neko.Web;
#else
  #error
#end

@:template 
class Main {
  static var EMPTY = Bytes.alloc(0);
  
  static var contentTypes = [
    'htm' => 'text/html',
    'html' => 'text/html',
    'xml' => 'text/xml',
    'txt' => 'text/plain',
    'css' => 'text/css',
    'js' => 'application/javascript',
    'png' => 'img/png',
    'gif' => 'img/gif',
    'jpg' => 'img/jpeg',
    'jpeg' => 'img/jpeg',
  ];
  
  static function getFile() {
    var path = '.' + Path.removeTrailingSlashes(Path.normalize(Web.getURI()));
    return
      try {
        var stat = FileSystem.stat(path);
        if (stat.size == 0 && FileSystem.isDirectory(path)) {
          Web.setReturnCode(403);
          EMPTY;
        }
        else {
          var ret = File.getBytes(path);
          Web.setHeader('Content-Size', Std.string(ret.length));
          switch contentTypes[Path.extension(path).toLowerCase()] {
            case null:
            case v:
              Web.setHeader('Content-Type', v);
          }
          ret;
        }
      }
      catch (e:Dynamic) {
        Web.setReturnCode(404);
        EMPTY;
      }
  }
	
	static function main() {
    #if foxhole
      Web.run({
        handler: serve,
        watch: true
      });        
    #else
      Web.cacheModule(serve);
      serve();
    #end
	}
  
  //@:template static var site;
  
  static function serve() {
    if (Web.getURI().startsWith('/assets/'))
      Sys.print(getFile());
    else {
      Web.setHeader('content-type', 'text/html');
      Sys.print(Main.document('WWX 2016 in Paris', homepage));      
    }
  }
	
}