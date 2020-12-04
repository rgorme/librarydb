"use strict";

const authors = require( "./authors" );
const books = require( "./books" );

module.exports.register = async server => {
   await authors.register( server ),
   await books.register( server );
};