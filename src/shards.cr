# Load .env file before any other config or app code
require "dotenv"
Dotenv.load? unless Lucky::Env.test?

# Require your shards here
require "avram"
require "lucky"
require "carbon"
require "authentic"
require "jwt"
require "raven"
require "raven/integrations/lucky"
