# Validate binaries
These .kai files were created from the same kallist binary. 

Note:
- I removed the .kai files and hex file from the remote repo (unnecessary space, or just to large)
- I created some hex snippets for demo purpose

### md5sums
I also checked the md5sums, they were all different. I thought that the indices itself cannot be different all the time... This would be documented somewhere ot at least duscuessed in fora


### reate hexa output
```
(base) maxpetzold@fedora-silverblue:/run/media/maxpetzold/HDD_5TB/HUB/Wildapfel/dge_from_scratch$ hexdump /run/media/maxpetzold/HDD_5TB/HUB/Wildapfel/dge_from_scratch/debugging/different_goea_outputs_when_rerunning/kallisto_index/test_hexa_output/Arabidopsis_thaliana.TAIR10.cdna.all.01.kai > /run/media/maxpetzold/HDD_5TB/HUB/Wildapfel/dge_from_scratch/debugging/different_goea_outputs_when_rerunning/kallisto_index/test_hexa_output/hex_01.txt
(base) maxpetzold@fedora-silverblue:/run/media/maxpetzold/HDD_5TB/HUB/Wildapfel/dge_from_scratch$ hexdump /run/media/maxpetzold/HDD_5TB/HUB/Wildapfel/dge_from_scratch/debugging/different_goea_outputs_when_rerunning/kallisto_index/test_hexa_output/Arabidopsis_thaliana.TAIR10.cdna.all.02.kai > /run/media/maxpetzold/HDD_5TB/HUB/Wildapfel/dge_from_scratch/debugging/different_goea_outputs_when_rerunning/kallisto_index/test_hexa_output/hex_02.txt
(base) maxpetzold@fedora-silverblue:/run/media/maxpetzold/HDD_5TB/HUB/Wildapfel/dge_from_scratch$ hexdump /run/media/maxpetzold/HDD_5TB/HUB/Wildapfel/dge_from_scratch/debugging/different_goea_outputs_when_rerunning/kallisto_index/test_hexa_output/Arabidopsis_thaliana.TAIR10.cdna.all.03.kai > /run/media/maxpetzold/HDD_5TB/HUB/Wildapfel/dge_from_scratch/debugging/different_goea_outputs_when_rerunning/kallisto_index/test_hexa_output/hex_03.txt
```

### inspected the hexa files

// hex_01.txt (10 lines)  
0000000 000d 0000 0000 0000 bfb4 012b 0000 0000  
0000010 0001 0000 5f3f 7e21 001f 0000 0017 0000  
0000020 2a05 0002 0000 0000 008b 0000 0000 0000  
0000030 d2c8 00cd 6986 271e 5022 2082 0e18 bf01  
0000040 782e c224 b241 49a4 6042 31e0 202f 2e4d  
0000050 7fae 2735 0000 0000 0000 cc00 480b 8b93  
0000060 5feb 0a4d 3d17 0000 0000 0000 d200 e2e4  
0000070 57fa c293 7f25 47f2 1453 09e5 2c01 0000  
0000080 0000 0000 fc00 1fc9 514d 2794 a8f4 0a5f  
0000090 0020 0000 0000 0000 5145 d09e 7ea3 e829  

// hex_02.txt (10 lines)  
0000000 000d 0000 0000 0000 c572 012b 0000 0000  
0000010 0001 0000 5f3f 7e21 001f 0000 0017 0000  
0000020 2a05 0002 0000 0000 008b 0000 0000 0000  
0000030 d2c8 00cd 6986 271e 5022 2082 0e18 bf01  
0000040 782e c224 b241 49a4 6042 31e0 202f 2e4d  
0000050 7fae 2735 0000 0000 0000 cc00 480b 8b93  
0000060 5feb 0a4d 3d17 0000 0000 0000 d200 e2e4  
0000070 57fa c293 7f25 47f2 1453 09e5 2c01 0000  
0000080 0000 0000 fc00 1fc9 514d 2794 a8f4 0a5f  
0000090 0020 0000 0000 0000 5145 d09e 7ea3 e829  

// hex_03.txt (10 lines)  
0000000 000d 0000 0000 0000 c236 012b 0000 0000  
0000010 0001 0000 5f3f 7e21 001f 0000 0017 0000  
0000020 2a05 0002 0000 0000 008b 0000 0000 0000  
0000030 d2c8 00cd 6986 271e 5022 2082 0e18 bf01  
0000040 782e c224 b241 49a4 6042 31e0 202f 2e4d  
0000050 7fae 2735 0000 0000 0000 cc00 480b 8b93  
0000060 5feb 0a4d 3d17 0000 0000 0000 d200 e2e4  
0000070 57fa c293 7f25 47f2 1453 09e5 2c01 0000  
0000080 0000 0000 fc00 1fc9 514d 2794 a8f4 0a5f  
0000090 0020 0000 0000 0000 5145 d09e 7ea3 e829  

- I saw that the first line was different, the rest was actually the same !
- I thought to inpsect the md5sum of the first line skipped might give insigh


### md5ums first line skipped 

```
tail -n +2 <HEXAFILE> | m5sum # skips the first line  
```

```
(base) maxpetzold@fedora-silverblue:/run/media/maxpetzold/HDD_5TB/HUB/Wildapfel/dge_from_scratch$ tail -n +2 /run/media/maxpetzold/HDD_5TB/HUB/Wildapfel/dge_from_scratch/debugging/different_goea_outputs_when_rerunning/kallisto_index/test_hexa_output/hex_01.txt | md5sum
b2f1dd0d6b48db2ee136ec05b9587211  -
(base) maxpetzold@fedora-silverblue:/run/media/maxpetzold/HDD_5TB/HUB/Wildapfel/dge_from_scratch$ tail -n +2 /run/media/maxpetzold/HDD_5TB/HUB/Wildapfel/dge_from_scratch/debugging/different_goea_outputs_when_rerunning/kallisto_index/test_hexa_output/hex_02.txt | md5sum
7f5e44cef327c7cddf79bc6c73e4ecd3  -
(base) maxpetzold@fedora-silverblue:/run/media/maxpetzold/HDD_5TB/HUB/Wildapfel/dge_from_scratch$ tail -n +2 /run/media/maxpetzold/HDD_5TB/HUB/Wildapfel/dge_from_scratch/debugging/different_goea_outputs_when_rerunning/kallisto_index/test_hexa_output/hex_03.txt | md5sum
4f1cd7a20438c233b4e1781d55344194  -
```
asddasdd