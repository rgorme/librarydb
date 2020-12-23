"use strict";

const boom = require( "boom" );

module.exports.register = async server => {
    server.route({
        method: "GET",
        path: "/api/books",
        config: {
            handler: async request => {
                try {
                    var BOOK_ID = -999;
                    if( typeof request.query.book_id !== 'undefined' && request.query.book_id ) {
                        BOOK_ID = request.query.book_id
                    };
                    const db = request.server.plugins.sql.client;
                    const res = await db.books.getBooks( BOOK_ID );
                    return res.recordset;
                } catch (err) {
                    console.log(err);
                }
            }
        }
    });

    server.route({
        method: "POST",
        path: "/api/books",
        config: {
            handler: async request => {
                try {
                    const db = request.server.plugins.sql.client;
                    const { BOOK_TITLE, BOOK_PAGE_NUMBER, BOOK_ISBN, BOOK_RESUME } = request.payload;
                    const res = await db.books.addBook( BOOK_TITLE, BOOK_PAGE_NUMBER, BOOK_ISBN, BOOK_RESUME );
                    return res.recordset[ 0 ];
                } catch (err) {
                    console.log(err);
                }
            }
        }
    });

    server.route({
        method: "DELETE",
        path: "/api/books/{BOOK_ID}",
        config: {
            handler: async request => {
                try {
                    const BOOK_ID = request.params.BOOK_ID;
                    const db = request.server.plugins.sql.client;
                    const res = await db.books.deleteBook( BOOK_ID );
                    return res.recordset[0].BOOK_DELETED === true ? "" : boom.notFound();
                } catch (err) {
                    console.log(err);
                }
            }
        }
    });

    server.route({
        method: "PUT",
        path: "/api/books/{BOOK_ID}",
        config: {
            handler: async request => {
                try {
                    const BOOK_ID = request.params.BOOK_ID;
                    const db = request.server.plugins.sql.client;
                    const { BOOK_TITLE, BOOK_PAGE_NUMBER, BOOK_ISBN, BOOK_RESUME } = request.payload;
                    const res = await db.books.updateBook( BOOK_TITLE, BOOK_PAGE_NUMBER, BOOK_ISBN, BOOK_RESUME, BOOK_ID );
                    const response = { data: res.recordset[0], statusCode: 200};
                    return response;
                } catch (err) {
                    console.log(err);
                }
            }
        }
    });
};