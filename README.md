# Playlist-Creator:

</br>

![Compiler](https://github.com/user-attachments/assets/a916143d-3f1b-4e1f-b1e0-1067ef9e0401) &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: ![10 Seattle](https://github.com/user-attachments/assets/c70b7f21-688a-4239-87c9-9a03a8ff25ab) ![10 1 Berlin](https://github.com/user-attachments/assets/bdcd48fc-9f09-4830-b82e-d38c20492362) ![10 2 Tokyo](https://github.com/user-attachments/assets/5bdb9f86-7f44-4f7e-aed2-dd08de170bd5) ![10 3 Rio](https://github.com/user-attachments/assets/e7d09817-54b6-4d71-a373-22ee179cd49c)   
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;![10 4 Sydney](https://github.com/user-attachments/assets/e75342ca-1e24-4a7e-8fe3-ce22f307d881) ![11 Alexandria](https://github.com/user-attachments/assets/64f150d0-286a-4edd-acab-9f77f92d68ad) ![12 Athens](https://github.com/user-attachments/assets/59700807-6abf-4e6d-9439-5dc70fc0ceca)  
![Components](https://github.com/user-attachments/assets/d6a7a7a4-f10e-4df1-9c4f-b4a1a8db7f0e) : ![None](https://github.com/user-attachments/assets/30ebe930-c928-4aaf-a8e1-5f68ec1ff349)  
![Discription](https://github.com/user-attachments/assets/4a778202-1072-463a-bfa3-842226e300af) &nbsp;&nbsp;: ![Playlist Creator](https://github.com/user-attachments/assets/f1da94f3-c393-4f67-947c-de4f685bd394)  
![Last Update](https://github.com/user-attachments/assets/e1d05f21-2a01-4ecf-94f3-b7bdff4d44dd) &nbsp;: ![102025](https://github.com/user-attachments/assets/62cea8cc-bd7d-49bd-b920-5590016735c0)  
![License](https://github.com/user-attachments/assets/ff71a38b-8813-4a79-8774-09a2f3893b48) &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: ![Freeware](https://github.com/user-attachments/assets/1fea2bbf-b296-4152-badd-e1cdae115c43)

</br>

A playlist is a list of video or audio files that can be played back on a media player, either sequentially or in a [shuffled](https://en.wikipedia.org/wiki/Shuffle_play) order.[1] In its most general form, an audio playlist is simply a list of songs that can be played once or in a loop. The term has several specialized meanings in the realms of television broadcasting, [radio broadcasting](https://en.wikipedia.org/wiki/Radio_broadcasting) and personal computers.

</br>

![Playlist Creator](https://github.com/user-attachments/assets/3bc842c4-034d-42aa-99ca-13d3adca583f)

</br>

### Featrues:
* Playlist Formats (m3u, m3u8, m3a, pls, xspf)
* Unicode Support
* Extended Playlists

For the most common Unicode formats, ```UTF-8``` or ```UTF-16 LE``` is required if the file name or link is written in a foreign language.

## M3U Format:
M3U (MP3) is a computer file format for a multimedia [playlist](https://en.wikipedia.org/wiki/Playlist). One common use of the M3U file format is creating a single-entry playlist file pointing to a [stream](https://en.wikipedia.org/wiki/Streaming_media) on the Internet. The created file provides easy access to that stream and is often used in downloads from a website, for emailing, and for listening to [Internet radio](https://en.wikipedia.org/wiki/Internet_radio).

Although originally designed for audio files, such as MP3, it is commonly used to point media players to audio and video sources, including online sources. M3U was originally developed by [Fraunhofer](https://en.wikipedia.org/wiki/Fraunhofer-Gesellschaft) for use with their [WinPlay3](https://en.wikipedia.org/wiki/WinPlay3) software,but numerous media players and software applications now support the format.

Careless handling of M3U playlists has been the cause of vulnerabilities in many music players such as [VLC media player](https://en.wikipedia.org/wiki/VLC_media_player), [iTunes](https://www.apple.com/de/itunes/), [Winamp](https://en.wikipedia.org/wiki/Winamp), and many others.

### Extended M3U:
The M3U file can also include comments, prefaced by the "#" character. In extended M3U, "#" also introduces extended M3U directives which are terminated by a colon ":" if they support parameters.

</br>

| Directive | Description | Example | Required | Standard |
| :----------- | :----------------- | :----------- | :----------- | :----------- |
| #EXTM3U      | file header, must be the first line of the file     | #EXTM3U     | 1x     | Yes     |
| #EXTINF:     | track information: runtime in seconds, then optional display title of the following resource. For runtime, a length of -1 or 0 may be used when media is a streaming file with no predefined length. | #EXTINF:123,Artist Name – Track Title artist - title.mp3 | No | Yes     |
| #PLAYLIST:   | playlist display title    | #PLAYLIST:Music TV     | 1x     | IPTV     |
| #EXTGRP:     | begin named grouping   |#EXTGRP:Foreign Channels   | No     | IPTV    |
| #EXTALB:     | album information, title in particular   | #EXTALB:Album Title (2009)   | 1x   | AL, M3A    |
| #EXTART:     | album artist  | #EXTART:Various  | 1x   | AL, M3A     |
| #EXTGENRE:   | album artist | #EXTART:Various  | 1x     | AL, M3A   |
| #EXTM3A      | playlist for tracks or chapters of an album in a single file  | #EXTM3A  | 1x   | M3A   |
| #EXTBYT:     | file size in bytes  | #EXTBYT:34124  | No   | M3A   |
| #EXTBIN:     | binary data follows, usually concatenated MP3s  | #EXTBIN:  | No  | M3A    |
| #EXTALBUMARTURL:  | url of album art image  | #EXTALBUMARTURL:https://example.com/a1b2c3d4.jpg  | No  | Jamendo/VLC   |

</br>

### M3U Example:
The following is an example of an M3U playlist file for "[Jar of Flies](https://en.wikipedia.org/wiki/Jar_of_Flies)" album by "[Alice in Chains](https://en.wikipedia.org/wiki/Alice_in_Chains)" that was created by Mp3tag with the following custom option settings

* playlist extended info format = "%artist% - %title%"
* playlist filename format = "%artist%_%album%_00_Playlist.m3u"
* tag to filename conversion format = "%artist%_%album%_$num(%track%,2)_%title%"

```pascal
 #EXTM3U
 #EXTINF:419,Alice in Chains - Rotten Apple
 Alice in Chains_Jar of Flies_01_Rotten Apple.mp3
 #EXTINF:260,Alice in Chains - Nutshell
 Alice in Chains_Jar of Flies_02_Nutshell.mp3
 #EXTINF:255,Alice in Chains - I Stay Away
 Alice in Chains_Jar of Flies_03_I Stay Away.mp3
 #EXTINF:256,Alice in Chains - No Excuses
 Alice in Chains_Jar of Flies_04_No Excuses.mp3
 #EXTINF:157,Alice in Chains - Whale And Wasp
 Alice in Chains_Jar of Flies_05_Whale And Wasp.mp3
 #EXTINF:263,Alice in Chains - Don't Follow
 Alice in Chains_Jar of Flies_06_Don't Follow.mp3
 #EXTINF:245,Alice in Chains - Swing On This
 Alice in Chains_Jar of Flies_07_Swing On This.mp3
````
</br>

## PLS Format:
PLS is a computer [file format](https://en.wikipedia.org/wiki/File_format) for a multimedia playlist. It is typically used by media players for streaming media over the Internet, but may also be used for playing local media.

For online streaming, typically the .PLS file would be downloaded just once from the media source—such as from an online radio station—for immediate or future use. While most computers and players automatically recognize the .PLS format, the first time a PLS file is used on a computer, the media player's settings may need to be changed to recognize ("associated" with) .PLS files.

PLS was originally developed for use with the museArc audio player software by codeArts, and was later used by [SHOUTcast](https://en.wikipedia.org/wiki/Shoutcast) and [Icecast](https://en.wikipedia.org/wiki/Icecast) for streaming media over the Internet.

### Examples:
Example of a complete PLS file used for "streaming audio;" in this case, to connect to a particular online radio station and receive its audio stream:

```pascal
[playlist]
File1=https://e20.yesstreaming.net:8279/
Title1=Here enter name of the station
NumberOfEntries=1
Alternative Example containing local paths:

[playlist]

File1=https://e20.yesstreaming.net:8279/
Length1=-1

File2=example2.mp3
Title2=Just some local audio that is 2mins long
Length2=120

File3=F:\Music\whatever.m4a
Title3=absolute path on Windows

File4=%UserProfile%\Music\short.ogg
Title4=example for an Environment variable
Length4=5

NumberOfEntries=4
Version=2
```

</br>

## XSPF Format:
[XML](https://en.wikipedia.org/wiki/XML) Shareable Playlist Format (XSPF), pronounced spiff, is an XML-based playlist format for digital media, sponsored by the [Xiph.Org Foundation](https://en.wikipedia.org/wiki/Xiph.Org_Foundation).

XSPF is a file format for sharing the kind of playlist that can be played on a personal computer or portable device. In the same way that any user on any computer can open any Web page, XSPF is intended to provide portability for playlists.

Traditionally playlists have been composed of file paths that pointed to individual titles. This allowed a playlist to be played locally on one machine or shared if the listed file paths were URLs accessible to more than one machine (e.g., on the Web). XSPF's meta-data rich open format has permitted a new kind of playlist sharing called content resolution.

A simple form of content resolution is the localisation of a playlist based on metadata. An XSPF-compliant content resolver will open XSPF playlists and search a catalog for every title with <creator>, <album> and <title> tags, then localise the playlist to reference the available matching tracks. A catalog may reference a collection of media files on a local disk, a music subscription service like Yahoo! Music Unlimited, or some other searchable archive. The end result is shareable playlists that are not tied to a specific collection or service.

### Example:
```xml
<?xml version="1.1" encoding="UTF-8"?>
<playlist version="1" xmlns="http://xspf.org/ns/0/">
  <trackList>
    <track>
      <title>Windows Path</title>
      <location>file://C:\music\foo.mp3</location>
    </track>
    <track>
      <title>Linux Path</title>
      <location>file:///media/music/foo.mp3</location>
    </track>
    <track>
      <title>Relative Path</title>
      <location>music/foo.mp3</location>
    </track>
    <track>
      <title>External Example</title>
      <location>http://www.example.com/music/bar.ogg</location>
    </track>
  </trackList>
</playlist>
````

</br>

### Software and web playlist converters:
* [VLC media player](https://images.videolan.org/) (stand-alone player, available on every major platform)
* [WinAmp](https://winamp.com/)
* [XMMS2](https://ubuntu.pkgs.org/25.04/ubuntu-universe-amd64/xmms2-plugin-xspf_0.8+dfsg-28build1_amd64.deb.html) (has a plugin to parse XSPF)
* [Last.fm](https://www.last.fm/de/) (export of playlists and personal tag radios in XSPF)
* [Soundiiz](https://soundiiz.com/) (playlist converter for several streaming sites)
* [Amarok](https://amarok.kde.org/)
* [Foobar2000](https://www.foobar2000.org/) (with appropriate plugin)
* [Audacious](https://audacious-media-player.org/)
* [Banshee](https://www.banshee-project.org/)
* [Clementine](https://www.clementine-player.org/)
* [Tomahawk](https://tomahawk-player.de.download.it/)
* youtube-dl (downloader)
