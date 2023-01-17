ObjectID = ObjectId;

// don't literally print 'ObjectId("300000000000000000000000")'...
// just give me the string
Object.defineProperty( ObjectId.prototype, 'toJSON', {
  value() {
    return this.valueOf();
  }
});

// Add Array#csv because people constantly ask me for shit in this terrible
// format and I'm sick of pasting JSON into some other tool in order to
// convert it
Object.defineProperty( Array.prototype, 'csv', {
  value() {
    const keys  = new Set;
    const lines = [];
    this.forEach( d => Object.keys( d ).forEach( k => keys.add( k ) ) );
    lines.push( Array.from( keys ).map( k => `"${ k }"` ).join(',') );
    this.forEach( d => {
      const line = [];
      keys.forEach( k => {
        let val = d[ k ] || '';
        if ( val instanceof ObjectId ) {
          val = val.valueOf();
        }
        line.push( val );
      });
      lines.push( line.map( l => `"${ l }"` ).join(',') );
    });
    return lines.join('\n');
  }
});

// uuid utility
uuid = ( () => {
  // byte to hex lookup
  const hex = [];
  for ( var i = 0; i < 256; ++i ) {
    hex[ i ] = ( i + 256 ).toString( 16 ).substr( 1 );
  }
  // format an array of bytes to a uuid string
  function format( a ) {
    let i = 0;
    return hex[ a[ i++ ] ] + hex[ a[ i++ ] ] +
      hex[ a[ i++ ] ] + hex[ a[ i++ ] ] + '-' +
      hex[ a[ i++ ] ] + hex[ a[ i++ ] ] + '-' +
      hex[ a[ i++ ] ] + hex[ a[ i++ ] ] + '-' +
      hex[ a[ i++ ] ] + hex[ a[ i++ ] ] + '-' +
      hex[ a[ i++ ] ] + hex[ a[ i++ ] ] +
      hex[ a[ i++ ] ] + hex[ a[ i++ ] ] +
      hex[ a[ i++ ] ] + hex[ a[ i++ ] ];
  }
  // get an array of 16 random bytes
  function rand() {
    const a = [];
    for ( let i = 0; i < 16; ++i ) {
      a.push( Math.floor( Math.random() * 256 ) );
    }
    return a;
  }
  // generate a uuid
  return function uuid() {
    const nums = rand();
    // reserved per RFC
    nums[ 6 ] = ( nums[ 6 ] & 15 ) | 64;
    nums[ 8 ] = ( nums[ 8 ] & 63 ) | 128;
    return format( nums );
  };
})();

// override default to not print on success 'cause it's annoying
shellHelper.use = name => {
  name = String( name );
  if ( name === '' ) {
    print('bad use parameter');
    return;
  }
  db = db.getMongo().getDB( name );
};

// padLeft/padRight
Object.defineProperty( String.prototype, 'padEnd', {
  value( n, s = ' ' ) {
    const tmpl = Array( n ).fill( s );

    for ( let i = 0; i < this.length; ++i ) {
      tmpl[ i ] = this[ i ];
    }

    return tmpl.join('');
  }
});

Object.defineProperty( String.prototype, 'padRight', {
  value: String.prototype.padEnd
});

Object.defineProperty( String.prototype, 'padStart', {
  value( n, s = ' ' ) {
    const out = this.split('');

    while ( out.length < n ) {
      out.unshift( s );
    }

    return out.join('');
  }
});

Object.defineProperty( String.prototype, 'padLeft', {
  value: String.prototype.padStart
});

// mac/serial stuff
function intToHex( int ) {
  return int.toString( 16 ).toUpperCase().padStart( 12, 0 );
}

function hexToInt( hex ) {
  return parseInt( hex, 16 );
}

function isTotem( hex ) {
  const num = hexToInt( hex );
  const min = 0x8CA2FD000000;
  const max = 0x8CA2FD01FFFF;

  return num >= min && num <= max;
}

function macToSerial( mac ) {
  if ( isTotem( mac ) ) {
    return intToHex( hexToInt( mac ) - 1 );
  }

  return mac;
}

function serialToMac( serial ) {
  if ( isTotem( serial ) ) {
    return intToHex( hexToInt( serial ) + 1 );
  }

  return serial;
}
