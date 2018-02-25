/*
 *  Created on: Sun Feb 25 2018 14.23
 *      Author: sadimanna
 */

#include<stdio.h>
#include<stdlib.h>

int main()
{
	char filename[] = "lenagray.bmp";
	int r,c,i,j,data,offset,hbytes,width,height;
	long bmpsize=0,bmpdataoff=0,bpp=0;
	int **image;
	int filter[3][3];
	int temp=0;
	
	//Reading the BMP File
	FILE *image_file;
	image_file = fopen(filename,"rb");
	if(image_file==NULL)
	{
		printf("Error Opening File!!");
		exit(1);
	}
	else
	{
		//Set file position of the stream to the beginning
		printf("Processing BMP Header...\n\n");
		offset = 0;
		fseek(image_file,offset,SEEK_SET);
		printf("Getting file ID...\n\n");
		for(i=0;i<2;i++)
		{
			fread(&data,1,1,image_file);
			printf("%c",data);
		}
		printf("\n\nGetting size of BMP File...\n\n");
		fread(&bmpsize,4,1,image_file);
		printf("Size of the BMP File:: %ld bytes\n\n",bmpsize);
		printf("Getting offset where the pixel arrray starts...\n\n");
		offset = 10;
		fseek(image_file,offset,SEEK_SET);
		fread(&bmpdataoff,4,1,image_file);
		printf("Bitmap data offset:: %ld\n\n",bmpdataoff);
		printf("DIB Header\n\n");
		fread(&hbytes,4,1,image_file);
		printf("Number of bytes in header:: %d\n\n",hbytes);
		fread(&width,4,1,image_file);
		fread(&height,4,1,image_file);
		printf("Width of Image: %d\n",width);
		printf("Height of image: %d\n\n",height);
		fseek(image_file,2,SEEK_CUR);
		fread(&bpp,2,1,image_file);
		printf("Number of bits per pixel: %ld\n\n",bpp);
		printf("Setting offset to start of pixel data...\n\n");
		fseek(image_file,bmpdataoff,SEEK_SET);
		printf("Creating Image array...\n\n");
		image = (int **)malloc(height*sizeof(int *));
		for(i=0;i<height;i++)
		{
			image[i] = (int *)malloc(width*sizeof(int));
		}
		//int image[height][width];
		int numbytes = (bmpsize - bmpdataoff)/3;
		printf("Number of bytes: %d \n\n",numbytes);
		int r,c;
		printf("Reading the BMP File into Image Array...\n\n");
		for(r=0;r<height;r++)
		{
			for(c=0;c<width;c++)
			{
				fread(&temp,3,1,image_file);
				temp = temp&0x0000FF;
				image[r][c] = temp;
			}
		}
		printf("Image array allocated...\n\n");
	}
	//Allocate Laplace Filter Array
	printf("Creating the Laplace Filter...\n\n");
	for(i=0;i<3;i++)
	{
		for(j=0;j<3;j++)
		{
			if(i==1 && j==1)
				filter[i][j] = 8;
			else
				filter[i][j] = -1;
		}
	}
	for(i=0;i<3;i++)
	{
		for(j=0;j<3;j++)
			printf("%d ",filter[i][j]);
		printf("\n");
	}
	//Point Detection
	//Padding
	printf("Padding the image array...\n\n");
	int temp_image[height+2][width+2];
	printf("Testing...\n\n");
	for(i=0;i<66;i++)
	{
		for(j=0;j<66;j++)
		{
			if(i==0 || j==0 || i==65 || j==65)
				temp_image[i][j] = 0;
			else
				temp_image[i][j] = image[i-1][j-1];
		}
	}
	printf("Padding the Image Array completed...\n\n");
	//2D Convolution
	int fimage[height][width];
	for(i=1;i<height+1;i++)
	{
		for(j=1;j<width+1;j++)
		{
			fimage[i-1][j-1] = temp_image[i-1][j-1]*filter[0][0]+temp_image[i-1][j]*filter[0][1]+temp_image[i-1][j+1]*filter[0][2]+temp_image[i][j-1]*filter[1][0]+temp_image[i][j]*filter[1][1]+temp_image[i][j+1]*filter[1][2]+temp_image[i+1][j-1]*filter[2][0]+temp_image[i+1][j]*filter[2][1]+temp_image[i+1][j+1]*filter[2][2];
		}
	}
	/**/
	//Thresholding
	int maxval = 0;
	printf("Adjusting values between 0 and 255 before writing to file...\n\n");
	for(r=0;r<height;r++)
	{
		for(c=0;c<width;c++)
		{
			if(fimage[r][c]>255)
				fimage[r][c] = 255;
			else if(fimage[r][c] < 0)
				fimage[r][c] = 0;
		}
	}
	for(r=0;r<height;r++)
	{
		for(c=0;c<width;c++)
		{
			if(fimage[r][c]>maxval)
				maxval = fimage[r][c];
		}
	}
	printf("Threshold :: %d\n\n",maxval);
	int finalImage[height][width];
	for(r=0;r<height;r++)
	{
		for(c=0;c<width;c++)
		{
			if(fimage[r][c]>=maxval)
				finalImage[r][c]=255;
			else
				finalImage[r][c]=0;
		}
	}
	//Writing to .pgm file
	FILE *lapImage = fopen("laplace.pgm","wb");
	fprintf(lapImage, "P2\n%d %d\n255\n", width,height);
	for (int i=height-1; i>=0; i--)
	{
		for (int j=0; j<width; j++)
		{
			temp = fimage[i][j];
			if(j==width-1)
				fprintf(lapImage,"%d\n",temp);
			else
				fprintf(lapImage,"%d ",temp); // 0 .. 255
	 	}
	}
	FILE *finImage = fopen("pointImage.pgm","wb");
	fprintf(finImage, "P2\n%d %d\n255\n", width,height);
	for (int i=height-1; i>=0; i--)
	{
		for (int j=0; j<width; j++)
		{
			temp = finalImage[i][j];
			if(j==width-1)
				fprintf(finImage,"%d\n",temp);
			else
				fprintf(finImage,"%d ",temp); // 0 .. 255
	 	}
	}
	fclose(image_file);
	fclose(lapImage);
	fclose(finImage);
	printf("Writing to new Image done...\n\n");
	return EXIT_SUCCESS;
}
