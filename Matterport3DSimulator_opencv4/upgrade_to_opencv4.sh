#!/bin/sh

find .  \( -name '*.cpp' -or -name '*.hpp' -or -name '*.h' \)  \
  -exec sed -i \
  -e 's/CV_IMWRITE_/cv::IMWRITE_/g' \
  -e 's/CV_LOAD_IMAGE_ANYDEPTH/cv::IMREAD_ANYDEPTH/g' \
  -e 's/CV_LOAD_IMAGE_COLOR/cv::IMREAD_COLOR/g' \
  -e 's/CV_L2/cv::NORM_L2/g' \
  -e 's/CV_TERMCRIT_EPS/cv::TermCriteria::EPS/g' \
  -e 's/CV_TERMCRIT_ITER/cv::TermCriteria::MAX_ITER/g' \
  -e 's/CV_CALIB_CB_/cv::CALIB_CB_/g' \
  -e 's/CV_BGR2GRAY/cv::COLOR_BGR2GRAY/g' \
  -e 's/CV_GRAY2BGR/cv::COLOR_GRAY2BGR/g' \
  -e 's/CV_HAAR_/cv::CASCADE_/g' \
  -e 's/CV_INTER_/cv::INTER_/g' \
  -e 's/CV_WARP_INVERSE_MAP/cv::WARP_INVERSE_MAP/g' \
  -e 's/CV_WINDOW_/cv::WINDOW_/g' \
  -e 's/CV_WND_/cv::WND_/g' \
  -e 's/CV_CAP_/cv::CAP_/g' \
  -e 's/CV_FOURCC/cv::VideoWriter::fourcc/g' \
  '{}' ';'