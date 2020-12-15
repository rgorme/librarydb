"use strict";

const utils = require( "../utils" );

const register = async ( { sql, getConnection } ) => {
   // read in all the .sql files for this folder
   const sqlQueries = await utils.loadSqlQueries( "authors" );

   async function getAuthors() {
        const pool = await getConnection();
        const request = await pool.request();
        return request.query(sqlQueries.getAuthors);
    };

   async function addAuthor(FIRST_NAME, LAST_NAME, NATIONALITY_SHORT, DESCRIPTION ) {
          const pool = await getConnection();
          const request = await pool.request();
          request.input("FIRST_NAME", sql.VarChar(250), FIRST_NAME);
          request.input("LAST_NAME", sql.VarChar(250), LAST_NAME);
          request.input("NATIONALITY_SHORT", sql.VarChar(5), NATIONALITY_SHORT);
          request.input("DESCRIPTION", sql.VarChar, DESCRIPTION);
          return request.query(sqlQueries.addAuthor);
     }

   async function updateAuthor( FIRST_NAME, LAST_NAME, NATIONALITY_SHORT, DESCRIPTION, AUTHOR_ID ) {
          const pool = await getConnection();
          const request = await pool.request();
          request.input("FIRST_NAME", sql.VarChar(250), FIRST_NAME);
          request.input("LAST_NAME", sql.VarChar(250), LAST_NAME);
          request.input("NATIONALITY_SHORT", sql.VarChar(5), NATIONALITY_SHORT);
          request.input("DESCRIPTION", sql.VarChar, DESCRIPTION);
          request.input("AUTHOR_ID", sql.Int, AUTHOR_ID);
          return request.query(sqlQueries.updateAuthor);
     }

    async function deleteAuthor( AUTHOR_ID ) {
          const pool = await getConnection();
          const request = await pool.request();
          request.input("AUTHOR_ID", sql.Int, AUTHOR_ID);
          return request.query(sqlQueries.deleteAuthor);
     }

   return {
        addAuthor,
        deleteAuthor,
        getAuthors,
        updateAuthor
   };
};

module.exports = { register };