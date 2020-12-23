"use strict";

const utils = require("../utils");

const register = async ({ sql, getConnection }) => {
    const sqlQueries = await utils.loadSqlQueries("books");

    async function getBooks( BOOK_ID=-999) {
        const pool = await getConnection();
        const request = await pool.request();
        request.input( "BOOK_ID", sql.Int, BOOK_ID );
        return request.query(sqlQueries.getBooks);
    };

    async function addBook( BOOK_TITLE, BOOK_PAGE_NUMBER, BOOK_ISBN, BOOK_RESUME) {
        const pool = await getConnection();
        const request = await pool.request();
        request.input( "BOOK_TITLE", sql.VarChar(1000), BOOK_TITLE);
        request.input( "BOOK_PAGE_NUMBER", sql.Int, BOOK_PAGE_NUMBER);
        request.input( "BOOK_ISBN", sql.VarChar(13), BOOK_ISBN);
        request.input( "BOOK_RESUME", sql.VarChar, BOOK_RESUME);
        return request.query(sqlQueries.addBook);
    };

    async function updateBook( BOOK_TITLE, BOOK_PAGE_NUMBER, BOOK_ISBN, BOOK_RESUME, BOOK_ID) {
        const pool = await getConnection();
        const request = await pool.request();
        request.input( "BOOK_TITLE", sql.VarChar(1000), BOOK_TITLE);
        request.input( "BOOK_PAGE_NUMBER", sql.Int, BOOK_PAGE_NUMBER);
        request.input( "BOOK_ISBN", sql.VarChar(13), BOOK_ISBN);
        request.input( "BOOK_RESUME", sql.VarChar, BOOK_RESUME);
        request.input( "BOOK_ID", sql.Int, BOOK_ID);
        return request.query(sqlQueries.updateBook);
    };

    async function deleteBook( BOOK_ID ) {
        const pool = await getConnection();
        const request = await pool.request();
        request.input("BOOK_ID", sql.Int, BOOK_ID);
        return request.query(sqlQueries.deleteBook);
    };

    return {
        addBook,
        deleteBook,
        getBooks,
        updateBook
    };
};

module.exports = { register };