App versions tested on: (might work for other versions too, YMMV)

PipePipe: 4.2.3
NewPipe: 0.27.6
Grayjay: 285

Converter for [NewPipe](https://github.com/TeamNewPipe/NewPipe) exports (tested for [PipePipe](https://github.com/InfinityLoop1308/PipePipe) exports too), converts them to [Grayjay](https://gitlab.futo.org/videostreaming/grayjay) imports

Caveats etc.:
1. Grayjay only exports 2000 history entries, so keep all the original exports from NewPipe or PipePipe around
2. Does not populate the caches for Grayjay currently so history will not be fully populated (thumbnails, channel etc. only title will be there), clicking on a video will populate it
3. If you already have been using Grayjay then make sure to make a backup before importing from this tool
4. Only imports the following:
   1. Subscriptions
   2. Playlists
   3. Watch History
5. It takes a lot of time for imports if you have a lot of data, do not kill the app during the import


To run:
1. Export the database from NewPipe/PipePipe (make sure to make multiple backups)
2. Unzip the export and get the database (should be at the root named newpipe.db)
3. Clone this project, cd into the directory you have cloned it to
4. Install ruby 3.x (https://github.com/rbenv/rbenv) (this project uses 3.3.6) if you don't already have it
5. Run `bundle install`
6. Run `./src/application.rb /path/to/newpipe/database/newpipe.db`
7. Use the generated zip file through Grayjay's import feature (choose the option that imports from a Grayjay export)