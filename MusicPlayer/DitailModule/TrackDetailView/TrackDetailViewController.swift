//
//  TrackDetailViewController.swift
//  MusicPlayer
//
//  Created by Михаил Липунцов on 23.06.2020.
//  Copyright © 2020 Дмитрий липунцов. All rights reserved.
//

import UIKit
import AVKit

class TrackDetailViewController: UIViewController {
    
    var presenter: TrackDetailPresenterProtocol?
    private var trackDetailView = TrackDetailView()
    var player: AVPlayer = {
        let avPlayer = AVPlayer()
        avPlayer.automaticallyWaitsToMinimizeStalling = false
        return avPlayer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        loadAllView()
        setTrack(track: presenter?.track)
        creatButtonsActions()
        creatSlidersAction()
    }
    
    func loadAllView() {
        view.addSubview(trackDetailView)
        trackDetailView.translatesAutoresizingMaskIntoConstraints = false
        trackDetailView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        trackDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        trackDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        trackDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        trackDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        
    }
    
    func playTrack(previewUrl: String?) {
        guard let url = URL(string: previewUrl ?? "") else { return }
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()

    }
    
    //MARK: - ButtonsActions
    
    func creatButtonsActions() {
        trackDetailView.dragDownButton.addTarget(
            self,
            action: #selector(dragDownButtonPressed),
            for: .touchUpInside
        )
        
        trackDetailView.trackControlView.previousTrackButton.addTarget(
            self,
            action: #selector(previousTrackButtonPressed),
            for: .touchUpInside
        )
        
        trackDetailView.trackControlView.playPauseButton.addTarget(
            self,
            action: #selector(playPouseButtonPressed),
            for: .touchUpInside
        )
        
        trackDetailView.trackControlView.nextTrackButton.addTarget(
            self,
            action: #selector(nextTrackButtonPressed),
            for: .touchUpInside
        )
    }
    
    @objc func dragDownButtonPressed() {
        
        dismiss(animated: true, completion: nil)
        navigationController?.isNavigationBarHidden = false//
        
    }
    
    //MARK: - Track control buttons actions
    
    @objc func previousTrackButtonPressed() {
        presenter?.nextTrack(isNextTrack: false)
    }
    
    @objc func playPouseButtonPressed() {
        if player.timeControlStatus == .paused {
            player.play()
            trackDetailView.trackControlView.playPauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        } else {
            player.pause()
            trackDetailView.trackControlView.playPauseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        }
    }
    
    @objc func nextTrackButtonPressed() {
        presenter?.nextTrack(isNextTrack: true)
    }
    
    //MARK: - SlidersAction
    
    func creatSlidersAction() {
        
        trackDetailView.volumeSlider.addTarget(
            self,
            action: #selector(handleVolumeSlider),
            for: .allEvents
        )
        
        trackDetailView.currentTimeSlider.addTarget(
            self,
            action: #selector(handelCurrentTimerSlider),
            for: .allEvents
        )
    }
    
    @objc func handleVolumeSlider() {
        player.volume = trackDetailView.volumeSlider.value
    }
    
    @objc func handelCurrentTimerSlider() {
        let percentage = trackDetailView.currentTimeSlider.value
        guard let duration = player.currentItem?.duration else { return }
        let durationInSeconds = CMTimeGetSeconds(duration)
        let seekTimeInSeconds = Float64(percentage) * durationInSeconds
        let seekTime = CMTimeMakeWithSeconds(seekTimeInSeconds, preferredTimescale: 1)
        player.seek(to: seekTime)
    }
    
}

extension TrackDetailViewController: TrackDetailViewProtocol {
    
    func setTrack(track: TrackModel.Track?) {
        trackDetailView.artistNameLabel.text = track?.artistName
        trackDetailView.trackNameLabel.text = track?.trackName
        let string600 = track?.iconUrlString?.replacingOccurrences(of: "100x100", with: "600x600")
        guard let url = URL(string: string600 ?? "") else { return }
        trackDetailView.trackImageView.sd_setImage(with: url)
        playTrack(previewUrl: track?.previewUrl)
        observePlayerCurrantTime()
        trackDetailView.trackControlView.playPauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
    }
    
    func observePlayerCurrantTime() {
        let interval = CMTime(value: 1, timescale: 2)
        player.addPeriodicTimeObserver(forInterval: interval, queue: nil, using: { [weak self] (time) in
            guard let self = self else { return }
            let durationTime = self.player.currentItem?.duration
            let currentDurationText = ((durationTime ?? CMTimeMake(value: 1, timescale: 1)) - time).toDisplayString()
            self.trackDetailView.durationLabel.text = "-\(currentDurationText)"
            self.updateCurrentTimeSlider()
        })
    }
    
    func updateCurrentTimeSlider() {
        let currentTimeSeconds = CMTimeGetSeconds(player.currentTime())
        let durationSeconds = CMTimeGetSeconds(player.currentItem?.duration ?? CMTimeMake(value: 1, timescale: 1))
        let percentage = currentTimeSeconds / durationSeconds
        self.trackDetailView.currentTimeSlider.value = Float(percentage)
    }
}
