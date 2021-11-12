% get res color bar 20211112
clc;
clear all;
% read color img
C = imread('tp6.jpg');
% blur...just for fun XD
B=imgaussfilt(C,1.6);
% gray the picture
G = rgb2gray(B);
% 2D->1D
D=reshape (G, 1, numel(G)); 
% draw his-graph
count = hist(D,0:1:255);
