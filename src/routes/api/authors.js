"use strict";

const boom = require( "boom" );

module.exports.register = async server => {
   server.route( {
       method: "GET",
       path: "/api/authors",
       config: {
           handler: async request => {
               try {
                   var AUTHOR_ID = -999;
                   if( typeof request.query.author_id !== 'undefined' && request.query.book_id ) {
                        AUTHOR_ID = request.query.author_id;
                   };
                   const db = request.server.plugins.sql.client;
                   const res = await db.authors.getAuthors( AUTHOR_ID );
                   return res.recordset;
               } catch ( err ) {
                   console.log( err );
               }
           }
       }
   } );

   server.route( {
        method: "POST",
        path: "/api/authors",
        config: {
            handler: async request => {
                try {
                    const db = request.server.plugins.sql.client;
                    const { FIRST_NAME, LAST_NAME, NATIONALITY_SHORT, DESCRIPTION } = request.payload;
                    const res = await db.authors.addAuthor( FIRST_NAME, LAST_NAME, NATIONALITY_SHORT, DESCRIPTION );
                    return res.recordset[ 0 ];
                } catch ( err ) {
                    console.log( err );
                }
            }
        }
   } );

   server.route( {
        method: "DELETE",
        path: "/api/authors/{AUTHOR_ID}",
        config: {
            response: {
                emptyStatusCode: 204
            },
            handler: async request => {
                try {
                    const AUTHOR_ID = request.params.AUTHOR_ID;
                    const db = request.server.plugins.sql.client;
                    const res = await db.authors.deleteAuthor( AUTHOR_ID );
                    return res.recordset[0].AUTHOR_DELETED === true ? "" : boom.notFound();
                } catch ( err ) {
                    console.log( err );
                }
            }
        }
   } );

   server.route( {
        method: "PUT",
        path: "/api/authors/{AUTHOR_ID}",
        config: {
            response: {
                emptyStatusCode: 204
            },
            handler: async request => {
                try {
                    const AUTHOR_ID = request.params.AUTHOR_ID;
                    const db = request.server.plugins.sql.client;
                    const { FIRST_NAME, LAST_NAME, NATIONALITY_SHORT, DESCRIPTION } = request.payload;
                    const res = await db.authors.updateAuthor( FIRST_NAME, LAST_NAME, NATIONALITY_SHORT, DESCRIPTION, AUTHOR_ID );
                    const response = { data: res.recordset[0], statusCode: 200};
                    return response;
                } catch ( err ) {
                    console.log( err );
                }
            }
        }
    } );
};