"use strict";

import express from "express";

const app = express();

app.use(express.static("dist"));

app.listen(process.env.PORT, () =>
  console.log(`Server is listening on port: ${process.env.PORT}`)
);
