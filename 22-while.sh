# #!/bin/bash

# ##Script to print each line one by one in a file

# while read content      #each line is stored in content and printed
# do
#     echo "Line is: $content"
# done < file-1.txt       #this is the file. It will be considered input



while IFS= read line
do
    echo "Line is: $line"
done < file-2.txt
