package;

import haxe.Timer;
using StringTools;
import js.Browser.*;

class Swag { 

  static function main() {
    var nav = document.getElementsByTagName('nav')[0];
    function updateNav() {
      if (window.scrollY > 100)
        nav.classList.remove('transparent');
      else
        nav.classList.add('transparent');
    }
    window.addEventListener('scroll', updateNav);
    updateNav();
    //return;
    var d:Dynamic = Date.now();
    d.setUTCDate(22);
    d.setUTCHours(15);
    d.setUTCMinutes(0);
    d.setUTCSeconds(0);
    
    var opens = (d : Date).getTime();
    var hours = document.querySelector('.countdown .hours'),
        minutes = document.querySelector('.countdown .minutes'),
        seconds = document.querySelector('.countdown .seconds');
        
    document.querySelector('.countdown').classList.remove('nodisplay');
    
    function updateTime() {
      
      var delta = Std.int((opens - Date.now().getTime()) / 1000);
      
      function time(target, f)
        return target.innerHTML = Std.string(Std.int(f)).lpad('0', 2);
        
      time(hours, delta / 3600);
      time(minutes, (delta % 3600) / 60);
      time(seconds, delta % 60);
      
    }
    updateTime();
    var t = new Timer(1000);
    t.run = updateTime;
  }
  
}