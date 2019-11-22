import numpy as np
import os
import time
import cv2
import shutil

thresh = 4000
delta_t = 0.035
outputnum = 3


def freq_encode(event, rgb_time, rgb_index, dir_path, event_time=[]):
    event_index = 0
    rgb_index_ = rgb_index
    for i in range(rgb_index_, len(rgb_time)):
        rgb_time_ = rgb_time[i]
        rgb_index += 1
        time_end = rgb_time_[1]
        start = time.time()

        outputlist = np.zeros((outputnum, 800, 1280))
        numlist = np.zeros(outputnum)
        event_index_ = event_index
        for j in range(event_index_, len(event)):
            event_ = event[j]
            if event_[0] < time_end:
                event_index += 1
                event_x = int(event_[2])
                event_y = int(event_[1])
                t = time_end - event_[0]
                index = int(t / delta_t)
                if index < outputnum:
                    outputlist[index][event_x][event_y] += 1
                    numlist[index] += 1
            else:
                break
        maxnum = numlist.max()
        maxindex = numlist.argmax()
        if maxnum >= thresh:
            # t1 = time_end - (maxindex + 1) * delta_t
            # t2 = time_end - maxindex * delta_t
            # event_time_ = [str(i), t1, t2]
            # event_time.append(event_time_)
            output = 255 * 2 * (1 / (1 + np.exp(-outputlist[maxindex])) - 0.5)
            filename = '%09d' % i
            cv2.imwrite(dir_path + '/' + filename + '.jpg', output)
            print('save image ' + str(i) + ' points: ' + str(maxnum))

        if event_index >= len(event):
            break

        end = time.time()
        print(end - start)

    return [event_time, rgb_index]


def read_timestamp(filename):
    time = []
    f = open(filename, mode='r')
    timeinfo = f.readlines()
    for time_ in timeinfo:
        time_ = time_.split()
        for i in range(1, len(time_)):
            time_[i] = float(time_[i])
        time.append(time_)
    f.close()    
    return time


def write_timestamp(filename, time, prefix=''):
    f = open(filename, mode='w')
    for time_ in time:
        time_[0] = '%03d' % int(time_[0][-3:])
        time_[0] = prefix + time_[0]
        for i in range(1, len(time_)):
            time_[i] = '%.9f' % time_[i]
        time_ = " ".join(time_)
        f.write(time_ + '\n')
    f.close()


def read_event(filename):
    event = []
    f = open(filename, mode='r')
    eventinfo = f.readlines()
    for event_ in eventinfo:
        event_ = event_.split()
        event_[0] = float(event_[0])
        event.append(event_)
    f.close()
    # sort
    # event.sort(key=lambda x: x[0])
    return event


def write_event(filename,event):
    f = open(filename, mode='w')
    for event_ in event:
        event_[0] = '%.6f' % event_[0]
        event_ = " ".join(event_)
        f.write(event_ + '\n')
    f.close()


if __name__ == '__main__':
    day_flag = True
    if day_flag:
        src = 'E:/ERID/raw_event/day'
        dst = 'E:/daytime'
        day_or_night = '0_'
    else:
        src = 'E:/ERID/raw_event/night'
        dst = 'E:/nighttime/image'
        day_or_night = '1_'

    folders = os.listdir(src)
    for folder in folders:
        src_path = src + '/' + folder
        dst_path = dst + '/' + folder
        if not os.path.exists(dst_path):
            os.mkdir(dst_path)
        print(src_path, 'begins!')

        prefix = day_or_night + folder[12:14] + '_'
        rgb_filename = src_path + '/rgb_time.txt'
        rgb_time = read_timestamp(rgb_filename)
        # write_timestamp(rgb_filename, rgb_time, prefix)
        #
        # infrared_filename = src_path + '/infrared_time.txt'
        # infrared_time = read_timestamp(infrared_filename)
        # write_timestamp(infrared_filename, infrared_time, prefix)

        dir_path = dst_path + '/dvs'
        #if os.path.exists(dir_path):
        #   shutil.rmtree(dir_path)
        #os.mkdir(dir_path)
        if not os.path.exists(dir_path):
            os.mkdir(dir_path)

        event_time = []
        rgb_index = 0
        for i in range(1, 20):
            event_path = src_path + '/' + str(i) + '.txt'
            if not os.path.exists(event_path):
                continue
            else:
                event = read_event(event_path)
                # write_event(event, event_path)
                [event_time, rgb_index] = freq_encode(event, rgb_time, rgb_index, dir_path, event_time)
        # event_filename = src_path + '/event_time.txt'
        # write_timestamp(event_filename, event_time, prefix)

