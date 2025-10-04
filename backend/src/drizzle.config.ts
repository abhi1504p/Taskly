import {defineConfig} from "drizzle-kit";
import dotenv from "dotenv";

dotenv.config()

export default defineConfig({
    dialect: "postgresql",
    schema: "./db/schema.ts",
    out: "./drizzle",
    dbCredentials: {
        host: "localhost",
        port: 5432,
        database: "mydb",
        user: process.env.POSTGRES_USER!,
        password: process.env.POSTGRES_PASSWORD!,
        ssl:false

    },
})