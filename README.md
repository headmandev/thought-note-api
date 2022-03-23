# Thought Note API
Rails API for saving notes.  
This project is necessary backend part of [Thought Note] service.


> Do not forget to create your own credentials file otherwise it will crash with an error.  
 
Remove `config/credentials.yml.enc`  
Run `EDITOR=vim rails credentials:edit` in the terminal and provide following params. It uses for test and development version also.  


```yaml
database:
  username: postgres
  password: 12345
```
This instruction also can help https://gist.github.com/db0sch/19c321cbc727917bc0e12849a7565af9
___
> For production version usage do not forget to create and specify
`.env`

```dotenv
APP_URL=https://your-thougt-note-app.com
APP_DATABASE_URL=postgres://YourUserName:YourPassword@YourHostname:5432/YourDatabaseName
```


## License

MIT

[Thought Note]: https://github.com/headmandev/thought-note
