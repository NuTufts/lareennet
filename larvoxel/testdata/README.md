Folder for testdata.

You can get the files at this [google drive location](https://drive.google.com/drive/folders/14x_DHhBvOqkA8ezCQGui-BQppRc29oQD?usp=sharing).

Make sure the `testdata.txt` file in the `larvoxel` folder points to these files.
In the config, you want to then refer to the location `testdata.txt` for the parameters

```
...
INPUT_TXTFILE_TRAIN: "testdata.txt"
INPUT_TXTFILE_VALID: "testdata.txt"
...
```

