USE LIBRARY;

DROP TABLE IF EXISTS BOOK_X_AUTHOR;
DROP TABLE IF EXISTS BOOK;
DROP TABLE IF EXISTS AUTHOR;
DROP TABLE IF EXISTS AUTHOR_ROLE;
DROP TABLE IF EXISTS AUTHOR_LOG;
DROP TABLE IF EXISTS AUTHOR_AUDIT;
DROP TABLE IF EXISTS BOOK_AUDIT;

CREATE TABLE AUTHOR_ROLE
(
    AUTHOR_ROLE_ID      INT             PRIMARY KEY IDENTITY(1,1),
    AUTHOR_ROLE_NAME    VARCHAR(250)    NOT NULL,
    DESCRIPTION         VARCHAR(MAX)    NULL,
    CREATED             DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    MODIFIED            DATETIME        NULL
);

CREATE TABLE AUTHOR
(
    AUTHOR_ID           INT             PRIMARY KEY IDENTITY(1,1),
    FIRST_NAME          VARCHAR(250)    NOT NULL,
    LAST_NAME           VARCHAR(250)    NOT NULL,
    NATIONALITY_SHORT   VARCHAR(5)      NULL,
    DESCRIPTION         VARCHAR(MAX)    NULL,
    CREATED             DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    MODIFIED            DATETIME        NULL
);

CREATE TABLE BOOK
(
    BOOK_ID             INT             PRIMARY KEY IDENTITY(1,1),
    BOOK_TITLE          VARCHAR(1000)   NOT NULL,
    BOOK_PAGE_NUMBER    INT             NOT NULL,
    BOOK_ISBN           VARCHAR(13)     NOT NULL,
    BOOK_RESUME         VARCHAR(MAX)    NULL,
    CREATED             DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    MODIFIED            DATETIME        NULL   
);

CREATE TABLE BOOK_X_AUTHOR
(
    BOOK_ID             INT                 NOT NULL        FOREIGN KEY REFERENCES BOOK(BOOK_ID),
    AUTHOR_ID           INT                 NOT NULL        FOREIGN KEY REFERENCES AUTHOR(AUTHOR_ID),
    AUTHOR_ROLE_ID      INT                 NOT NULL        FOREIGN KEY REFERENCES AUTHOR_ROLE(AUTHOR_ROLE_ID),
    CREATED             DATETIME            NOT NULL        DEFAULT CURRENT_TIMESTAMP,
    MODIFIED            DATETIME            NULL
    CONSTRAINT          PK_BOOK_X_AUTHOR    PRIMARY KEY     (BOOK_ID, AUTHOR_ID)
);

CREATE TABLE AUTHOR_AUDIT
(
    AUDIT_ID                    INT                     PRIMARY KEY IDENTITY(-1000000,1),
    AUDIT_OPEATION              CHAR(3)                 NOT NULL,
    AUDIT_TIME                  DATETIME                NOT NULL DEFAULT CURRENT_TIMESTAMP,
    AUDIT_ROW_TYPE              CHAR(3)                 NOT NULL,
    AUDIT_SESSION               uniqueidentifier        NOT NULL,
    AUTHOR_ID                   INT                     NOT NULL,
    FIRST_NAME                  VARCHAR(250)            NOT NULL,
    LAST_NAME                   VARCHAR(250)            NOT NULL,
    NATIONALITY_SHORT           VARCHAR(5)              NULL,
    DESCRIPTION                 VARCHAR(MAX)            NULL,
);

CREATE TABLE BOOK_AUDIT
(
    AUDIT_ID                    INT                     PRIMARY KEY IDENTITY(-1000000,1),
    AUDIT_OPEATION              CHAR(3)                 NOT NULL,
    AUDIT_TIME                  DATETIME                NOT NULL DEFAULT CURRENT_TIMESTAMP,
    AUDIT_ROW_TYPE              CHAR(3)                 NOT NULL,
    AUDIT_SESSION               uniqueidentifier        NOT NULL,
    BOOK_ID                     INT                     NOT NULL,
    BOOK_TITLE                  VARCHAR(1000)           NOT NULL,
    BOOK_PAGE_NUMBER            INT                     NOT NULL,
    BOOK_ISBN                   VARCHAR(13)             NOT NULL,
    BOOK_RESUME                 VARCHAR(MAX)            NULL
)